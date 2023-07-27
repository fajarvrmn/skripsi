<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/**
 * route "/register"
 * @method "POST"
 */

/**
 * route "/login"
 * @method "POST"
 */
Route::post('/api_login', App\Http\Controllers\Api\LoginController::class)->name('api_login');

/**
 * route "/user"
 * @method "GET"
 */
Route::middleware('auth:api')->get('/api_user', function (Request $request) {
    return $request->user();
});

Route::group(['middleware' => ['auth:api']], function() {
    Route::get('/api_dashboard', [App\Http\Controllers\Api\ApiDashboardController::class, 'index'])->name('api_dashboard');
    Route::get('/api_pendapatan', [App\Http\Controllers\Api\ApiLaporanController::class, 'index'])->name('api_pendapatan');
    Route::get('/api_portlet', [App\Http\Controllers\Api\ApiPortletController::class, 'data'])->name('api_portlet');
    Route::post('/api_logout', App\Http\Controllers\Api\LogoutController::class)->name('api_logout');
    Route::post('/api_update_profile', [App\Http\Controllers\Api\ApiUserController::class, 'updateProfil'])->name('api_update_profile');
    Route::post('/api_register', App\Http\Controllers\Api\RegisterController::class)->name('api_register');
    Route::get('/api_pengeluaran', [App\Http\Controllers\Api\ApiPengeluaranController::class, 'data'])->name('api_pengeluaran');
    Route::get('/api_pengeluaran_by_date', [App\Http\Controllers\Api\ApiPengeluaranController::class, 'data_by_date'])->name('api_pengeluaran_by_date');
    Route::get('/api_pengeluaran_store', [App\Http\Controllers\Api\ApiPengeluaranController::class, 'store'])->name('api_pengeluaran_store');
    Route::get('/api_pengeluaran_get/{id}', [App\Http\Controllers\Api\ApiPengeluaranController::class, 'show'])->name('api_pengeluaran_get');
    Route::get('/api_pengeluaran_update/{id}', [App\Http\Controllers\Api\ApiPengeluaranController::class, 'update'])->name('api_pengeluaran_update');
    Route::get('/api_pengeluaran_delete/{id}', [App\Http\Controllers\Api\ApiPengeluaranController::class, 'destroy'])->name('api_pengeluaran_delete');
    Route::get('/get_pesanan_menunggu', [App\Http\Controllers\Api\ApiPenjualanController::class, 'menunggu'])->name('get_pesanan_menunggu');
    Route::get('/kirim_pesanan/{id}', [App\Http\Controllers\Api\ApiListpoController::class, 'create'])->name('kirim_pesanan');
    Route::delete('/delete_pesanan/{id}', [App\Http\Controllers\Api\ApiPenjualanController::class, 'destroy'])->name('delete_pesanan');
    Route::get('/get_pesanan_berjalan', [App\Http\Controllers\Api\ApiListpoController::class, 'data'])->name('get_pesanan_berjalan');
    Route::get('/get_penjualan/{id}', [App\Http\Controllers\Api\ApiPenjualanController::class, 'show'])->name('get_penjualan');
    Route::get('/update_penjualan/{id}', [App\Http\Controllers\Api\ApiListpoController::class, 'update'])->name('update_penjualan');
    Route::get('/get_gaji', [App\Http\Controllers\Api\ApiGajiController::class, 'data'])->name('get_gaji');
    Route::get('/get_detail_list_po/{id}', [App\Http\Controllers\Api\ApiListpoController::class, 'show'])->name('get_detail_list_po');
    Route::get('/get_pegawai', [App\Http\Controllers\Api\ApiListpoController::class, 'pegawai'])->name('get_pegawai');
    // Route::group(['middleware' => 'level:1'], function () {
        
    // });
});

/**
 * route "/logout"
 * @method "POST"
 */
