<?php

namespace App\Services;

use App\Enums\PostStatus;
use App\Enums\SubmissionStatus;
use App\Models\Post;
use Illuminate\Support\Facades\DB;

/** Satu jalur penerbitan untuk tombol "Terbitkan" dan scheduler posting terjadwal. */
class PublishPostService
{
    public function publish(Post $post): Post
    {
        if ($post->status === PostStatus::Published) {
            return $post;
        }

        return DB::transaction(function () use ($post) {
            $post->update([
                'status' => PostStatus::Published,
                'published_at' => now(),
            ]);

            if ($post->type->requiresSubmissions()) {
                $this->createSubmissions($post);
            }

            return $post;
        });
    }

    /** Satu baris submissions per siswa; aman dipanggil ulang. */
    private function createSubmissions(Post $post): void
    {
        $now = now();

        $rows = $post->course->students()->pluck('users.id')
            ->map(fn (int $studentId) => [
                'post_id' => $post->id,
                'student_id' => $studentId,
                'status' => SubmissionStatus::Assigned->value,
                'created_at' => $now,
                'updated_at' => $now,
            ])
            ->all();

        DB::table('submissions')->insertOrIgnore($rows);
    }
}
