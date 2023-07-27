<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Mail;

class MailController extends Controller
{
    public function forgotPassword($email, $token)
    {
        $linkResetPassword = url("reset-password/{$token}");

        $details = [
            'title' => 'Reset Password',
            'link'  => $linkResetPassword
        ];

        Mail::to($email)->send(new \App\Mail\ForgotPasswordMail($details));

        # MAIL TESTING
        # Mail::to('yourmail@gmail.com')->send(new \App\Mail\ForgotPasswordMail($details));
    }
}
