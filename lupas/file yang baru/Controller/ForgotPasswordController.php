<?php

namespace App\Http\Controllers;

use App\Models\PasswordReset;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;

class ForgotPasswordController extends Controller
{
    public function getEmail()
    {
        return view('auth.forgotPassword');
    }

    public function postEmail(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
        ]);

        $isUserExist = User::where('email', $request->email)->first();

        if(!$isUserExist){
            return back()->with('failed', 'Email tidak terdaftar pada aplikasi.');
        }

        $isEmailExist = PasswordReset::where('email', $request->email)->first();

        if($isEmailExist){
            $isTokenExpired = PasswordReset::isTokenExpired($isEmailExist->token);

            if(!$isTokenExpired){
                return back()->with('failed', 'Email gagal terkirim! Mohon mencoba lagi dalam beberapa saat.');
            }

            PasswordReset::where('email', $request->email)->delete();
        }

        $tokenizer = config('app.name') .'//' . mt_rand(1000000000,9999999999) . '//' . time();
        $token = md5($tokenizer);

        PasswordReset::insert(
            ['email' => $request->email, 'token' => $token, 'created_at' => now()]
        );

        try {
            $mail = new MailController();
            $mail->forgotPassword($request->email, $token);
            $status = 'success';
            $message = 'Email berhasil terkirim! Silahkan periksa kotak masuk Email Anda.';

        } catch (Exception $err) {
            $status = 'failed';
            $message = $err->getMessage();
        }

        return back()->with($status, $message);
    }
}
