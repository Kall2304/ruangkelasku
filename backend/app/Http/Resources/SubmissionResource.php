<?php

namespace App\Http\Resources;

use App\Enums\PostType;
use App\Enums\SubmissionStatus;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/** Butuh relasi post. Siswa pemilik tidak pernah menerima draft_grade. */
class SubmissionResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $isOwner = $request->user()->id === $this->student_id;
        $isQuiz = $this->post->type === PostType::Quiz;
        // Kunci jawaban kuis baru terlihat siswa setelah dikembalikan.
        $showCorrectness = ! $isOwner || $this->status === SubmissionStatus::Returned;

        return [
            'id' => $this->id,
            'post_id' => $this->post_id,
            'student' => new UserSummaryResource($this->whenLoaded('student')),
            'status' => $this->status,
            'display_status' => $this->displayStatusFor($request->user()),
            'is_late' => $this->is_late,
            'draft_grade' => $this->when(! $isOwner, fn () => self::number($this->draft_grade)),
            'grade' => self::number($this->grade),
            'turned_in_at' => $this->turned_in_at?->toIso8601ZuluString(),
            'returned_at' => $this->returned_at?->toIso8601ZuluString(),
            'attachments' => AttachmentResource::collection($this->whenLoaded('attachments')),
            'quiz_answers' => $isQuiz && $this->relationLoaded('quizAnswers')
                ? $this->quizAnswers->map(fn ($answer) => [
                    'question_id' => $answer->quiz_question_id,
                    'option_id' => $answer->quiz_option_id,
                    'is_correct' => $showCorrectness ? $answer->is_correct : null,
                ])->values()
                : null,
            'private_comment_count' => $this->whenCounted('privateComments'),
        ];
    }

    private static function number(?string $value): ?float
    {
        return $value === null ? null : (float) $value;
    }
}
