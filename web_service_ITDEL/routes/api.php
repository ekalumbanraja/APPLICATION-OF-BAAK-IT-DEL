<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\RequestIzinKeluarController;
use App\Http\Controllers\RequestIzinBermalamController;
use App\Http\Controllers\RequestSuratController;
use App\Http\Controllers\AdminIzinKeluarController;
use App\Http\Controllers\AdminIzinBermalamController;
use App\Http\Controllers\AdminBookingRuanganController;
use App\Http\Controllers\BookingRuanganController;
use App\Http\Controllers\PemesananController;
use App\Http\Controllers\AdminSuratController;
use App\Http\Controllers\RuanganController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::post('/register',[AuthController::class,'register']);
Route::post('/login',[AuthController::class,'login']);

Route::group(['middleware'=>['auth:sanctum']],function(){
 
    Route::get('/user',[RequestIzinKeluarController::class, 'user']);
    Route::post('/logout',[RequestIzinKeluarController::class, 'logout']);

    
    //Baak
    //Aprove_IK
     Route::get('/admin/izinkeluar',[AdminIzinKeluarController::class, 'index']);
     Route::get('/admin/izinkeluars',[AdminIzinKeluarController::class, 'indexsemua']);
     Route::put('/admin/izin-keluar/approve/{id}', [AdminIzinKeluarController::class, 'approve']);
     Route::put('/admin/izin-keluar/rejected/{id}', [AdminIzinKeluarController::class, 'rejected']);
    
    //Aprove_IB
    Route::get('/admin/izinbermalam',[AdminIzinBermalamController::class, 'index']);
    Route::get('/admin/izinbermalams',[AdminIzinBermalamController::class, 'indexsemua']);
    Route::put('/admin/izin-bermalam/approve/{id}', [AdminIzinBermalamController::class, 'approve']);
    Route::put('/admin/izin-bermalam/rejected/{id}', [AdminIzinBermalamController::class, 'rejected']);

    //Aprove_Surat
    Route::get('/admin/surat',[AdminSuratController::class, 'index']);
    Route::get('/admin/surats',[AdminSuratController::class, 'indexsemua']);
    Route::put('/admin/surat/approve/{id}', [AdminSuratController::class, 'approve']);
    Route::put('/admin/surat/rejected/{id}', [AdminSuratController::class, 'rejected']);

    //Aprove_Booking_Ruangan
    Route::get('/admin/bookingruangan',[AdminBookingRuanganController::class, 'index']);
    Route::get('/admin/bookingruangans',[AdminBookingRuanganController::class, 'indexsemua']);
    Route::put('/admin/bookingruangan/approve/{id}', [AdminBookingRuanganController::class, 'approve']);
    Route::put('/admin/bookingruangan/rejected/{id}', [AdminBookingRuanganController::class, 'rejected']);


     //Mahasiswa
    //Izin_Bermalam
    Route::get('/izinbermalam',[RequestIzinBermalamController::class, 'index']);
    Route::post('/izinbermalam',[RequestIzinBermalamController::class, 'store']);
    Route::put('/izinbermalam/{id}',[RequestIzinBermalamController::class, 'update']);
    Route::get('/izinbermalam/{id}',[RequestIzinBermalamController::class, 'show']);
    Route::delete('/izinbermalam/{id}',[RequestIzinBermalamController::class, 'destroy']);


    //Izin_Keluar
    Route::get('/izinkeluar',[RequestIzinKeluarController::class, 'index']);
    Route::post('/izinkeluar',[RequestIzinKeluarController::class, 'store']);
    Route::put('/izinkeluar/{id}',[RequestIzinKeluarController::class, 'update']);
    Route::get('/izinkeluar/{id}',[RequestIzinKeluarController::class, 'show']);
    Route::delete('/izinkeluar/{id}',[RequestIzinKeluarController::class, 'destroy']);

     //Izin_Surat
     Route::get('/surat',[RequestSuratController::class, 'index']);
     Route::post('/surat',[RequestSuratController::class, 'store']);
     Route::put('/surat/{id}',[RequestSuratController::class, 'update']);
     Route::get('/surat/{id}',[RequestSuratController::class, 'show']);
     Route::delete('/surat/{id}',[RequestSuratController::class, 'destroy']);

    //Booking_Ruangan
    Route::get('/booking-ruangan', [BookingRuanganController::class, 'index']);
     Route::post('/booking-ruangan', [BookingRuanganController::class, 'bookRoom']);
     Route::post('/cek-ruangan', [BookingRuanganController::class, 'RoomAvailable']);
     Route::delete('/booking-ruangan/{id}', [BookingRuanganController::class, 'destroy']);

     //Pemesanan
     Route::get('/pemesanan', [PemesananController::class, 'index']);
     Route::post('/pemesanan', [PemesananController::class, 'store']);

  
      Route::get('/ruangan', [RuanganController::class, 'index']);
      Route::get('/kaos', [PemesananController::class, 'indexsemua']);
});
