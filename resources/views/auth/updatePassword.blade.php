@extends('layouts.auth')

@section('title')
Reset Password
@endsection

@section('login')

@if(!$token)
<div class="mt-5 pt-5">
    <p class="text-center">{{ $message }}</p>
</div>
@else
<div class="login-box">
    <div class="login-box-body">
        <div class="col text-center">
            <h3>
                <label>
                    RESET PASSWORD
                </label>
            </h3>
        </div>
        <br>
        <form action="{{ route('reset-password.update') }}" method="post" class="form-login">
            @csrf
            <input type="hidden" name="token" value="{{ $token }}" required>

            <div class="form-group has-feedback @error('password') has-error @enderror">
                <input type="password" name="password" class="form-control" placeholder="Password" required>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                @error('password')
                    <span class="help-block">{{ $message }}</span>
                @else
                    <span class="help-block with-errors"></span>
                @enderror
            </div>
            <div class="form-group has-feedback @error('password_confirmation') has-error @enderror">
                <input type="password" name="password_confirmation" class="form-control" placeholder="Password Confirmation" required>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                @error('password_confirmation')
                    <span class="help-block">{{ $message }}</span>
                @else
                    <span class="help-block with-errors"></span>
                @enderror
            </div>
            <div class="row" style="display: flex; align-items:center;">
                <div class="col-xs-6">
                </div>
                <div class="col-xs-6 text-right">
                    <button type="submit" class="btn btn-primary">Reset Password</button>
                </div>
            </div>
        </form>
    </div>
</div>
@endif

@endsection
