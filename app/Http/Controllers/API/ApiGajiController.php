<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class ApiGajiController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __invoke(Request $request)
    {
        //
    }

    public function data(Request $request)
    {
        // $listpo = Listpo::with('status')->orderBy('id', 'desc')->get();
        $gaji = DB::table('list_po')
       ->select('list_po.kode_po as kode', 'list_po.id_penjualan as nopes', 'users.name as pegawai', 'list_po.updated_at as selesai', 'penggajian.harga as harga', 'penggajian.bonus as bonus', 'penggajian.tanggal_selesai as po_selesai',
        DB::raw('(penggajian.harga + penggajian.bonus) as total'))
        ->join('users','users.id','=','list_po.assigne')
        ->join('penggajian','list_po.id','=','penggajian.id_list_po')
        ->whereRaw('tanggal_selesai IN (SELECT MAX(tanggal_selesai) FROM penggajian group by id_list_po)');


        $awal = isset($request->tanggal_awal) ? $request->tanggal_awal : '';
        $akhir = isset($request->tanggal_akhir) ? $request->tanggal_akhir : '';
        $tgl_awal  = date($awal) . ' 00:00:00';
        $tgl_akhir = date($akhir) . ' 23:59:59';
        // dd($awal, $akhir);

        if (Auth::user()->level == 1) { # ADMIN
            if ($awal != null && $akhir != null && $request->assigne != null) {
                if ($request->tanggal_awal <= $request->tanggal_akhir) {
                    $gaji = $gaji->where('list_po.id_statuses', '=', '6')
                        ->where('list_po.assigne', '=', $request->assigne)
                        ->whereBetween('list_po.updated_at', [$tgl_awal, $tgl_akhir]);
                }
            } elseif ($awal != null && $akhir != null && $request->assigne == null) {
                if ($request->tanggal_awal <= $request->tanggal_akhir) {
                    $gaji = $gaji->where('list_po.id_statuses', '=', '6')
                        ->whereBetween('list_po.updated_at', [$tgl_awal, $tgl_akhir]);
                }
            } elseif ($request->assigne != null && $awal == null && $akhir == null) {
                $gaji = $gaji->where('list_po.id_statuses', '=', '6')
                    ->where('list_po.assigne', '=', $request->assigne);
            } else {
                
                $gaji = $gaji->where('list_po.id_statuses', '=', '6');
            }
        } else { # PEGAWAI
            if ($request->tanggal_awal != null && $request->tanggal_akhir != null) {
                if ($request->tanggal_awal <= $request->tanggal_akhir) {
                    $gaji = $gaji->where('list_po.id_statuses', '=', '6')
                        ->where('list_po.assigne', '=', Auth::user()->id)
                        ->whereBetween('list_po.updated_at', [$tgl_awal, $tgl_akhir]);
                }
            } else {
                $gaji = $gaji->where('list_po.id_statuses', '=', '6')
                    ->where('list_po.assigne', '=', Auth::user()->id);
            }
        }

        return response()->json([
            'result' => true,
            'data' => $gaji->get(),
            'total_data' => $gaji->get()->count()
        ], 200);

        // return $gaji->get();

        // return datatables()
        //     ->of($gaji->get())
        //     ->addIndexColumn()
        //     // ->addColumn('aksi', function ($gaji) {
        //     //     return '
        //     //     <div class="btn-group">
        //     //         <button onclick="editForm(`'. route('gaji.update', $gaji->id) .'`)" class="btn btn-xs btn-info btn-flat"><i class="fa fa-pencil"></i></button>
        //     //         <button onclick="deleteData(`'. route('gaji.destroy', $gaji->id) .'`)" class="btn btn-xs btn-danger btn-flat"><i class="fa fa-trash"></i></button>
        //     //     </div>
        //     //     ';
        //     // })
        //     ->rawColumns(['aksi'])
        //     ->make(true);
    }
}
