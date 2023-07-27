@extends('layouts.auth')

@section('title')
Log in
@endsection

@section('login')
<div class="login-box">
    @if (Session::has('reset-pass'))
    <div class="alert alert-success text-center" role="alert" style="position:relative;">
        <strong>{{ Session::get('reset-pass') }}</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="color: #fff;opacity:1;position:absolute;top:1px;right:6px;">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    @endif
    <!-- /.login-logo -->
    <div class="login-box-body">
        <div class="col-xs-8">
                   <h3>
                        <label>
                            SISTEM MANAJEMEN STOK WANGI PROJECT
                        </label>
                   </h3>
                </div><br>
        <div class="login-logo">
            <a href="{{ url('/') }}">
                <img src="{{ url($setting->path_logo) }}" alt="logo.png" width="100">
            </a>
        </div>

        <form action="{{ route('login') }}" method="post" class="form-login">
            @csrf
            <div class="form-group has-feedback @error('email') has-error @enderror">
                <input type="email" name="email" class="form-control" placeholder="Email" required value="{{ old('email') }}" autofocus>
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                @error('email')
                    <span class="help-block">{{ $message }}</span>
                @else
                <span class="help-block with-errors"></span>
                @enderror
            </div>
            <div class="form-group has-feedback @error('password') has-error @enderror">
                <input type="password" name="password" class="form-control" placeholder="Password" required>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                @error('password')
                    <span class="help-block">{{ $message }}</span>
                @else
                    <span class="help-block with-errors"></span>
                @enderror
            </div>
            <div class="row" style="display: flex; align-items:center;">
                <div class="col-xs-6">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox"> Remember Me
                        </label>
                    </div>
                </div>
                <div class="col-xs-6 text-right">
                    <a href="{{ route('forget-password.request') }}"><u>Forget Password?</u></a>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-xs-8"></div>
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                </div>
            </div>
        </form>
    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
@endsection
