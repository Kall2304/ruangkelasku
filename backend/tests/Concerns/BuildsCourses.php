<?php

namespace Tests\Concerns;

use App\Enums\CourseRole;
use App\Enums\PostStatus;
use App\Enums\PostType;
use App\Models\Course;
use App\Models\Post;
use App\Models\User;
use App\Services\PublishPostService;

trait BuildsCourses
{
    protected function addStudent(Course $course, ?User $student = null): User
    {
        $student ??= User::factory()->create();
        $course->users()->attach($student->id, ['role' => CourseRole::Student->value]);

        return $student;
    }

    protected function addTeacher(Course $course, ?User $teacher = null): User
    {
        $teacher ??= User::factory()->create();
        $course->users()->attach($teacher->id, ['role' => CourseRole::Teacher->value]);

        return $teacher;
    }

    protected function makePost(Course $course, PostType $type = PostType::Assignment, bool $publish = true): Post
    {
        $post = Post::create([
            'course_id' => $course->id,
            'author_id' => $course->owner_id,
            'type' => $type,
            'title' => $type === PostType::Announcement ? null : 'Judul',
            'points' => $type === PostType::Assignment ? 100 : null,
            'status' => PostStatus::Draft,
            'position' => 0,
        ]);

        if ($publish) {
            app(PublishPostService::class)->publish($post);
        }

        return $post->fresh();
    }
}
