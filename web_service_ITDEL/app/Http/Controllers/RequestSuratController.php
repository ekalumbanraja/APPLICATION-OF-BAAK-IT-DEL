<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\RequestSurat; 
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\User;

class RequestSuratController extends Controller
{
   /**
     * Create a new leave request.
     *
     * @param  Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        // Mendapatkan pengguna yang sedang login
        $user = Auth::user();
    
        // Mengambil data RequestSurat sesuai dengan user yang login
        $izinKeluarData = RequestSurat::where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->get();
    
        return response([
            'RequestSurat' => $izinKeluarData
        ], 200);
    }
    public function show($id)
    {
        return response([
            'RequestSurat' => RequestSurat::where('id', $id)->get()
        ], 200);
    }
    

    public function store(Request $request)
    {
        
        $rules = [
            'reason' => 'required|string',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }
      
        $user = RequestSurat::create([
            'reason' => $request->input('reason'),
            'user_id' => auth()->user()->id
        ]);
        return response([
            'message' => 'Request Izin Keluar dibuat',
            'RequestSurat'=>$user
        ], 200);
    }

    public function update(Request $request,$id)
    {
        $RequestSurat= RequestSurat::find($id);
       if(!$RequestSurat){
        return response([
            'message' => 'Request Izin Keluar Tidak Ditemukan',
        ], 403);
       }
       if($RequestSurat->user_id !=auth()->user()->id){
        return response([
            'message' => 'Akun Anda Tidak mengakses Ini',
        ], 403);
       }
       $validator = Validator::make($request->all(), [
        'reason' => 'required|string'
    ]);

    if ($validator->fails()) {
        return response()->json($validator->errors(), 400);
    }
       $RequestSurat->update([
         'reason' => $request->input('reason'),
    ]);
    return response([
        'message' => 'Request Izin Keluar Telah Diupdate',
        'RequestSurat'=>$RequestSurat
    ], 200);
    }
    
   public function destroy($id){
    $RequestSurat= RequestSurat::find($id);
    if(!$RequestSurat){
     return response([
         'message' => 'Request Izin Keluar Tidak Ditemukan',
     ], 403);
    }
    if($RequestSurat->user_id !=auth()->user()->id){
     return response([
         'message' => 'Akun Anda Tidak mengakses Ini',
     ], 403);
    }
    $RequestSurat->delete();
    return response([
        'message' => 'Request Izin Keluar Telah Dihapus',
        'RequestSurat'=>$user
    ], 200);
   }
}
