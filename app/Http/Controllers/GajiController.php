<?php

namespace App\Http\Controllers;

use App\Models\User;
use PDF;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class GajiController extends Controller
{
    /**
     * Display a listing of the resource.

     */
    public function index()
    {
        $pegawai = User::where('level', '!=', '1')->get();
        return view('gaji.index', compact('pegawai'));
    }

    public function data(Request $request)
    {
        // $listpo = Listpo::with('status')->orderBy('id', 'desc')->get();
        
        //QUERY ASLI
        // $gaji = DB::table('list_po')
        //     ->join('users', 'users.id', '=', 'list_po.assigne')
        //     ->join('penggajian', 'list_po.id', '=', 'penggajian.id_list_po')
        //     ->where('penggajian.tanggal_selesai IN (SELECT MAX( tanggal_selesai ) FROM penggajian')
        //     ->select('list_po.kode_po as kode', 'list_po.id_penjualan as nopes', 'users.name as pegawai', 'list_po.updated_at as selesai', 'penggajian.harga as harga', 'penggajian.bonus as bonus', 'penggajian.tanggal_selesai as po_selesai',
        //     DB::raw('penggajian.harga + penggajian.bonus as total'))
        //     ->groupBy('penggajian.id_list_po');

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

        return datatables()
            ->of($gaji->get())
            ->addIndexColumn()
            // ->addColumn('aksi', function ($gaji) {
            //     return '
            //     <div class="btn-group">
            //         <button onclick="editForm(`'. route('gaji.update', $gaji->id) .'`)" class="btn btn-xs btn-info btn-flat"><i class="fa fa-pencil"></i></button>
            //         <button onclick="deleteData(`'. route('gaji.destroy', $gaji->id) .'`)" class="btn btn-xs btn-danger btn-flat"><i class="fa fa-trash"></i></button>
            //     </div>
            //     ';
            // })
            ->rawColumns(['aksi'])
            ->make(true);
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function cetak(Request $request) {
        $awal = isset($request->tanggal_awal) ? $request->tanggal_awal : '';
        $akhir = isset($request->tanggal_akhir) ? $request->tanggal_akhir : '';
        $awal  =  date($awal) . ' 00:00:00';
        $akhir = date($akhir) . ' 23:59:59';

        $nama_bulan = array(1 =>
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember');

        $bulan = date('n', strtotime($akhir));
        $bulan = $nama_bulan[$bulan];
        
        $gaji = DB::table('list_po')
            ->join('users', 'users.id', '=', 'list_po.assigne')
            ->join('penggajian', 'list_po.id', '=', 'penggajian.id_list_po')
            ->select('list_po.kode_po as kode', 'users.name as pegawai', 'list_po.updated_at as selesai',
                'penggajian.harga as harga', 'penggajian.bonus as bonus', 'penggajian.tanggal_selesai as po_selesai',
                DB::raw('penggajian.harga + penggajian.bonus as total'))
            ->where('list_po.id_statuses', '=', '6');

        if (Auth::user()->level == 1) {
            if ($awal != null && $akhir != null && $request->assigne != null) {
                if ($request->tanggal_awal <= $request->tanggal_akhir) {
                    $gaji = $gaji->where('list_po.id_statuses', '=', '6')
                        ->where('list_po.assigne', '=', $request->assigne)
                        ->whereBetween('list_po.updated_at', [$awal, $akhir])->get();
                }
            }
            $pegawai = DB::table('users')->where('id', '=', $request->assigne)->first();
        } else {
            if ($request->tanggal_awal != null && $request->tanggal_akhir != null) {
                if ($request->tanggal_awal <= $request->tanggal_akhir) {
                    $gaji = $gaji->where('list_po.id_statuses', '=', '6')
                        ->where('list_po.assigne', '=', Auth::user()->id)
                        ->whereBetween('list_po.updated_at', [$awal, $akhir])->get();
                }
            } else {
                $gaji = $gaji->where('list_po.id_statuses', '=', '6')
                    ->where('list_po.assigne', '=', Auth::user()->id)->get();
            }
            $pegawai = DB::table('users')->where('id', '=', Auth::user()->id)->first();
        }

        // dd($request->all());
        // dd($pegawai);
        $html = view('gaji.cetak', ['gaji' => $gaji, 'pegawai' => $pegawai, 'bulan' => $bulan])->render();
        PDF::setOptions(['isHtml5ParserEnabled' => true]);
        $pdf = PDF::loadHTML($html);
        $pdf->setPaper('A5', 'potrait');
        // $pdf->setMargin(0);
        return $pdf->stream('slip-gaji.pdf');
    }
}
