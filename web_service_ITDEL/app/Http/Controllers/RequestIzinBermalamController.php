<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\RequestIzinBermalam; 
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\User;

class RequestIzinBermalamController extends Controller
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
    
        // Mengambil data RequestIzinBermalam sesuai dengan user yang login
        $izinKeluarData = RequestIzinBermalam::where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->get();
    
        return response([
            'RequestIzinBermalam' => $izinKeluarData
        ], 200);
    }
    public function show($id)
    {
        return response([
            'RequestIzinBermalam' => RequestIzinBermalam::where('id', $id)->get()
        ], 200);
    }
    

    public function store(Request $request)
    {
        $rules = [
            'reason' => 'required|string',
            'start_date' => 'required|date_format:Y-m-d H:i:s',
            'end_date' => 'required|date_format:Y-m-d H:i:s',
        ];
    
        $validator = Validator::make($request->all(), $rules);
    
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }
    
        $startDateTime = new \DateTime($request->input('start_date'));
        $endDateTime = new \DateTime($request->input('end_date'));
    
        // Check if the request is made on Friday after 17:00 or on Saturday between 08:00 and 17:00
        if (!($startDateTime->format('N') == 5 && $startDateTime->format('H') >= 17) &&
            !($startDateTime->format('N') == 6 && $startDateTime->format('H') >= 8 && $startDateTime->format('H') < 17) &&
            !($endDateTime->format('N') == 6 && $endDateTime->format('H') < 17)) {
            return response()->json(['message' => 'Izin bermalam hanya bisa direquest pada Jumat setelah pukul 17:00 dan Sabtu antara pukul 08:00 - 17:00.'], 403);
        }
    
        $user = RequestIzinBermalam::create([
            'reason' => $request->input('reason'),
            'start_date' => $startDateTime,
            'end_date' => $endDateTime,
            'user_id' => auth()->user()->id,
        ]);
    
        return response([
            'message' => 'Request Izin Keluar dibuat',
            'RequestIzinBermalam' => $user
        ], 200);
    }
    


    public function update(Request $request, $id)
{
    $requestIzinBermalam = RequestIzinBermalam::find($id);

    if (!$requestIzinBermalam) {
        return response([
            'message' => 'Request Izin Keluar Tidak Ditemukan',
        ], 403);
    }

    if ($requestIzinBermalam->user_id != auth()->user()->id) {
        return response([
            'message' => 'Akun Anda Tidak mengakses Ini',
        ], 403);
    }

    $validator = Validator::make($request->all(), [
        'reason' => 'required|string',
        'start_date' => 'required|date_format:Y-m-d H:i:s',
        'end_date' => 'required|date_format:Y-m-d H:i:s',
    ]);

    if ($validator->fails()) {
        return response()->json($validator->errors(), 400);
    }

    $startDateTime = new \DateTime($request->input('start_date'));
    $endDateTime = new \DateTime($request->input('end_date'));

    // Check if the request is made on Friday after 17:00 or on Saturday between 08:00 and 17:00
    if (!($startDateTime->format('N') == 5 && $startDateTime->format('H') >= 17) &&
        !($startDateTime->format('N') == 6 && $startDateTime->format('H') >= 8 && $startDateTime->format('H') < 17) &&
        !($endDateTime->format('N') == 6 && $endDateTime->format('H') < 17)) {
        return response()->json(['message' => 'Izin bermalam hanya bisa direquest pada Jumat setelah pukul 17:00 dan Sabtu antara pukul 08:00 - 17:00.'], 403);
    }

    $requestIzinBermalam->update([
        'reason' => $request->input('reason'),
        'start_date' => $startDateTime,
        'end_date' => $endDateTime,
    ]);

    return response([
        'message' => 'Request Izin Keluar Telah Diupdate',
        'RequestIzinBermalam' => $requestIzinBermalam
    ], 200);
}

    
   public function destroy($id){
    $RequestIzinBermalam= RequestIzinBermalam::find($id);
    if(!$RequestIzinBermalam){
     return response([
         'message' => 'Request Izin Keluar Tidak Ditemukan',
     ], 403);
    }
    if($RequestIzinBermalam->user_id !=auth()->user()->id){
     return response([
         'message' => 'Akun Anda Tidak mengakses Ini',
     ], 403);
    }
    $RequestIzinBermalam->delete();
    return response([
        'message' => 'Request Izin Keluar Telah Dihapus',
        'RequestIzinBermalam'=>$user
    ], 200);
   }
}
