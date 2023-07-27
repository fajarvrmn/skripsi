@extends('layouts.auth')

@section('title')
Reset Password
@endsection

@section('login')
<div class="login-box">
    @if (Session::has('success'))
    <div class="alert alert-success text-center" role="alert" style="position:relative;">
        <strong>{{ Session::get('success') }}</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="color: #fff;opacity:1;position:absolute;top:1px;right:6px;">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    @elseif(Session::has('failed'))
    <div class="alert alert-danger text-center" role="alert" style="position:relative;">
        <strong>{{ Session::get('failed') }}</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="color: #fff;opacity:1;position:absolute;top:1px;right:6px;">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    @endif
    <div class="login-box-body">
        <div class="col text-center">
            <h3>
                <label>
                    RESET PASSWORD
                </label>
            </h3>
        </div>
        <br>
        <form action="{{ route('forget-password.email') }}" method="post" class="form-login">
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
            <div class="row" style="display: flex; align-items:center;">
                <div class="col-xs-6">
                    <a href="{{ route('login') }}"><u>Kembali</u></a>
                </div>
                <div class="col-xs-6 text-right">
                    <button type="submit" class="btn btn-primary">Kirim Email</button>
                </div>
            </div>
        </form>
    </div>
</div>
@endsection
