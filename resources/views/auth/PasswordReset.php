<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class PasswordReset extends Model
{
    use HasFactory;

    protected $table = 'password_resets';
    protected $guarded = [];

    public static function isTokenExpired($token)
    {
        $data = DB::table('password_resets')
            ->selectRaw("TIMESTAMPDIFF(HOUR, created_at, NOW()) AS duration")
            ->where('token', '=', $token)
            ->get();

        $duration = $data[0]->duration;
        $exp_time = 1; # SET EXPIRED (IN HOUR)

        if($duration >= $exp_time) return true;

        return false;
    }
}
