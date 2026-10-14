<?php

use App\Http\Controllers\Api\V1\AttachmentController;
use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\CommentController;
use App\Http\Controllers\Api\V1\CourseController;
use App\Http\Controllers\Api\V1\InvitationController;
use App\Http\Controllers\Api\V1\MemberController;
use App\Http\Controllers\Api\V1\PostController;
use App\Http\Controllers\Api\V1\ProfileController;
use App\Http\Controllers\Api\V1\TopicController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    Route::post('auth/register', [AuthController::class, 'register']);
    Route::post('auth/login', [AuthController::class, 'login']);

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('auth/logout', [AuthController::class, 'logout']);

        Route::get('me', [ProfileController::class, 'show']);
        Route::patch('me', [ProfileController::class, 'update']);
        Route::post('me/avatar', [ProfileController::class, 'updateAvatar']);
        Route::get('me/invitations', [InvitationController::class, 'mine']);

        // Kelas
        Route::post('courses/join', [CourseController::class, 'join']);
        Route::get('courses', [CourseController::class, 'index']);
        Route::post('courses', [CourseController::class, 'store']);
        Route::get('courses/{course}', [CourseController::class, 'show']);
        Route::patch('courses/{course}', [CourseController::class, 'update']);
        Route::delete('courses/{course}', [CourseController::class, 'destroy']);
        Route::post('courses/{course}/code/reset', [CourseController::class, 'resetCode']);
        Route::post('courses/{course}/archive', [CourseController::class, 'archive']);
        Route::post('courses/{course}/restore', [CourseController::class, 'restore']);

        // Anggota
        Route::get('courses/{course}/members', [MemberController::class, 'index']);
        Route::delete('courses/{course}/members/{user}', [MemberController::class, 'destroy']);
        Route::delete('courses/{course}/membership', [MemberController::class, 'leave']);

        // Undangan
        Route::get('courses/{course}/invitations', [InvitationController::class, 'index']);
        Route::post('courses/{course}/invitations', [InvitationController::class, 'store']);
        Route::delete('invitations/{invitation}', [InvitationController::class, 'destroy']);
        Route::post('invitations/{invitation}/accept', [InvitationController::class, 'accept']);
        Route::post('invitations/{invitation}/decline', [InvitationController::class, 'decline']);

        // Topik
        Route::get('courses/{course}/topics', [TopicController::class, 'index']);
        Route::post('courses/{course}/topics', [TopicController::class, 'store']);
        Route::put('courses/{course}/topics/order', [TopicController::class, 'reorder']);
        Route::patch('topics/{topic}', [TopicController::class, 'update']);
        Route::delete('topics/{topic}', [TopicController::class, 'destroy']);

        // Posting: Stream dan Tugas Kelas membaca tabel posts yang sama
        Route::get('courses/{course}/stream', [PostController::class, 'stream']);
        Route::get('courses/{course}/classwork', [PostController::class, 'classwork']);
        Route::get('courses/{course}/posts/upcoming', [PostController::class, 'upcoming']);
        Route::post('courses/{course}/posts', [PostController::class, 'store']);
        Route::get('posts/{post}', [PostController::class, 'show']);
        Route::patch('posts/{post}', [PostController::class, 'update']);
        Route::delete('posts/{post}', [PostController::class, 'destroy']);
        Route::post('posts/{post}/publish', [PostController::class, 'publish']);
        Route::put('posts/{post}/position', [PostController::class, 'move']);

        // Lampiran dan komentar kelas
        Route::post('posts/{post}/attachments', [AttachmentController::class, 'store']);
        Route::delete('attachments/{attachment}', [AttachmentController::class, 'destroy']);
        Route::get('posts/{post}/comments', [CommentController::class, 'index']);
        Route::post('posts/{post}/comments', [CommentController::class, 'store']);
        Route::delete('comments/{comment}', [CommentController::class, 'destroy']);
    });
});
