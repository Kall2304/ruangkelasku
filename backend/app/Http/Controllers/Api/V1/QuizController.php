<?php

namespace App\Http\Controllers\Api\V1;

use App\Enums\PostType;
use App\Enums\SubmissionStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\Quiz\SaveQuizRequest;
use App\Http\Resources\QuizQuestionResource;
use App\Models\Post;
use App\Services\QuizService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Gate;

class QuizController extends Controller
{
    /** Guru melihat kunci jawaban; siswa hanya setelah submission-nya dikembalikan. */
    public function show(Request $request, Post $post): JsonResponse
    {
        Gate::authorize('view', $post);
        abort_unless($post->type === PostType::Quiz, 404, 'Posting ini bukan kuis.');
        $user = $request->user();

        $showAnswers = $user->isTeacherOf($post->course)
            || $post->submissions()
                ->where('student_id', $user->id)
                ->where('status', SubmissionStatus::Returned)
                ->exists();

        return $this->questions($post->quizQuestions()->with('options')->get(), $showAnswers);
    }

    public function update(SaveQuizRequest $request, Post $post, QuizService $quiz): JsonResponse
    {
        return $this->questions($quiz->save($post, $request->validated('questions')), showAnswers: true);
    }

    private function questions(Collection $questions, bool $showAnswers): JsonResponse
    {
        return response()->json([
            'data' => $questions->map(fn ($question) => new QuizQuestionResource($question, $showAnswers))->values(),
        ]);
    }
}
