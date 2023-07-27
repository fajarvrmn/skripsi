<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Gaji;
use App\Models\User;
use App\Models\Listpo;
use App\Models\Status;
use App\Models\Penjualan;
use App\Models\ApiAssigne;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class ApiListpoController extends Controller
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

        // $getAssigne = Listpo::select(DB::Raw('users.name as pegawai'))
        // ->join('users','users.id', '=', 'list_po.assigne');

        $listpo = Listpo::select(DB::Raw('list_po.id as id, penjualan.created_at as tgl_order, penjualan.status AS status_penjualan, penjualan.id_penjualan as no_pesanan, list_po.kode_po as kode_po, start_date as mulai, end_date as selesai,
        assigne as penugasan, status.nama as status, users.name as nama_user, (SELECT users.name FROM users WHERE users.id = list_po.assigne) AS pegawai'))
        ->join('status', 'status.id', '=', 'list_po.id_statuses')
        ->join('penjualan', 'penjualan.id_penjualan', '=', 'list_po.id_penjualan')
        ->join('users', 'users.id', '=', 'list_po.id_user')->orderBy('list_po.created_at','desc');

        if($_REQUEST){

            $search = $_REQUEST['search'];

            $listpo = $listpo->where('list_po.id_penjualan', 'LIKE', "'%$search%'")->orWhere('status.nama', 'LIKE', "'%$search%'");

        }

        if (Auth::user()->level == 1) {
            // echo 'lvl 1';
            if ($request->assigne != null) {
                // echo 'assigne tdk null';
                $listpo = $listpo->where('list_po.assigne', '=', $request->assigne);
            } else {
                // echo 'assigne null';
            }
        } else {
            // echo 'lvl != 1';
            // echo auth()->user()->id;
            $listpo = $listpo->where('list_po.assigne', '=', auth()->user()->id);
        }

        return response()->json([
            'result' => true,
            'data' => $listpo->get(),
            'total_data' => $listpo->get()->count()
        ], 200);

        // dd($listpo->toSql());

        // print_r($listpo);
        // exit;
       
        // return datatables()
        //     ->of($listpo->get())
        //     ->addIndexColumn()
        //     ->addColumn('aksi', function ($listpo) {
        //         if ($listpo->status == 3 || strtolower($listpo->status) == "selesai") {
        //             return '
        //         <div class="btn-group">
        //             <button onclick="deleteData(`'. route('listpo.destroy', $listpo->id) .'`)" class="btn btn-xs btn-danger btn-flat"><i class="fa fa-trash"></i></button>
        //         </div>
        //         ';
        //     } else {
        //         return '
        //         <div class="btn-group">
        //         <button onclick="deleteData(`'. route('listpo.destroy', $listpo->id) .'`)" class="btn btn-xs btn-danger btn-flat"><i class="fa fa-trash"></i></button>
        //         <button onclick="editForm(`'. route('listpo.update', $listpo->id) .'`)" class="btn btn-xs btn-info btn-flat"><i class="fa fa-pencil"></i></button>
        //         </div>
        //         ';
        //     }
        //     })
        //     ->rawColumns(['aksi'])
        //     ->make(true);
    }

    public function create($id_penjualan)
    {
        $query_kode_po = Listpo::latest()->first() ?? new listpo();
        $kode_po = 'PO-'. tambah_nol_didepan((int)$query_kode_po->id +1, 6);

        $listpo = new Listpo();
        $listpo->kode_po = $kode_po;
        $listpo->id_user = auth()->id();
        $listpo->id_penjualan = $id_penjualan;
        $listpo->id_statuses = '1';

        $listpo->save();

        // $query_update_status = 

        $penjualan = Penjualan::find($id_penjualan);
        $penjualan->status = 3;
        $penjualan->update();

        return response()->json([
            'status' => true,
            'message' => 'Kirim Pesanan Success'
        ], 200);
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
        // $assigne = User::where('id', '!=', 1)->pluck('name', 'id')->all();
        $assigne = ApiAssigne::select('id', 'name')->where('id', '!=', 1)->get();
        $status = Status::all();
        $listpo = Listpo::find($id);
        $user_input = User::where('id', $listpo['id_user'])->pluck('name')->all();

        return response()->json(['list' => $listpo, 'assigne' => $assigne, 'status' => $status, 'user_input' => $user_input]);
    }

    public function pegawai()
    {
        // $assigne = User::where('id', '!=', 1)->pluck('name', 'id')->all();
        $pegawai = ApiAssigne::select('id', 'name')->where('id', '!=', 1)->get();
        // $status = Status::all();
        // $listpo = Listpo::find($id);
        // $user_input = User::where('id', $listpo['id_user'])->pluck('name')->all();

        return response()->json([
            'response' => true,
            'data' => $pegawai,
            'total_data' => $pegawai->count()
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {

       


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
        $listpo = Listpo::find($id);
        $listpo->update($request->all());

        if ($request->id_statuses == 6) {
            $gaji = new Gaji();
            $gaji->id_list_po = $id;
            $gaji->tanggal_selesai = $listpo->updated_at;
            $gaji->harga = 10000;
            $gaji->bonus = 0;
            $gaji->total = $gaji->harga + $gaji->bonus;
            $gaji->save();
        }

        return response()->json([
            'result' => true,
            'message' => 'Data berhasil disimpan'
        ], 200);
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
}