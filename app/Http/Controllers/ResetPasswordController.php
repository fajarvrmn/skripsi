<?php

namespace App\Http\Controllers;

use App\Models\PasswordReset;
use App\Models\User;
use Illuminate\Http\Request;

class ResetPasswordController extends Controller
{
    public function getPassword($token)
    {
        $data = PasswordReset::where('token', $token)->first();

        if(!$data){
            return abort(404, 'Page Not Found');
        }

        $isTokenExpired = PasswordReset::isTokenExpired($data->token);

        if($isTokenExpired){
            // PasswordReset::where('email', $data->email)->delete();
            return  view('auth.updatePassword', ['message' => 'Link Kadaluarsa! Silahkan melakukan permintaan reset password kembali.', 'token' => '']);
        }

        return view('auth.updatePassword', ['message' => 'success', 'token' => $token]);
    }

    public function updatePassword(Request $request)
    {
        $request->validate([
            'password' => 'required|required_with:password_confirmation|same:password_confirmation',
            'password_confirmation' => 'required',
        ]);

        $data = PasswordReset::where('token', $request->token)->first();

        $password = bcrypt($request->password);

        $user = User::where('email', $data->email);
        $user->update(['password'=> $password]);

        if($user){
            PasswordReset::where('email', $data->email)->delete();
        }

        return redirect()->route('login')->with('reset-pass', 'Berhasil mengubah password!');
    }
}
