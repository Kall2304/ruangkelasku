<?php

use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\CourseController;
use App\Http\Controllers\Api\V1\InvitationController;
use App\Http\Controllers\Api\V1\MemberController;
use App\Http\Controllers\Api\V1\ProfileController;
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
    });
});
