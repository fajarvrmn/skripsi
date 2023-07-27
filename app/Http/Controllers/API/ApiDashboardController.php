<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
// use Illuminate\Support\Facades\Hash;

use App\Models\Kategori;
use App\Models\Member;
use App\Models\Pembelian;
use App\Models\Pengeluaran;
use App\Models\Penjualan;
use App\Models\Produk;
use App\Models\Supplier;
use App\Models\Listpo;

class ApiDashboardController extends Controller
{

    public function index()
    {
        $kategori = Kategori::count();
        $produk = Produk::count();
        $supplier = Supplier::count();
        $member = Member::count();
        $listpo = Listpo::count();
        
        //per status list po
        $listpo = Listpo::count(); //total all
        $listpo_1 = Listpo::where('id_statuses','=','1')->count(); //pengerjaan
        $listpo_2 = Listpo::where('id_statuses','=','2')->count(); //decor
        $listpo_3 = Listpo::where('id_statuses','=','3')->count(); //design
        $listpo_4 = Listpo::where('id_statuses','=','4')->count(); //grafir
        $listpo_5 = Listpo::where('id_statuses','=','5')->count(); //revisi
        $listpo_6 = Listpo::where('id_statuses','=','6')->count(); //selesai
        
        // $penjualan2 = Penjualan::count()->WHERE('status','=','1');
        $penjualan2 = Penjualan::where('status','=','1')->count();

        $tanggal_awal = date('Y-m-01');
        $tanggal_akhir = date('Y-m-d');

        $data_tanggal = array();
        $data_pendapatan = array();

        while (strtotime($tanggal_awal) <= strtotime($tanggal_akhir)) {
            $data_tanggal[] = (int) substr($tanggal_awal, 8, 2);

            $total_penjualan = Penjualan::where('created_at', 'LIKE', "%$tanggal_awal%")->sum('bayar');
            $total_pembelian = Pembelian::where('created_at', 'LIKE', "%$tanggal_awal%")->sum('bayar');
            $total_pengeluaran = Pengeluaran::where('created_at', 'LIKE', "%$tanggal_awal%")->sum('nominal');

            $pendapatan = $total_penjualan - $total_pembelian - $total_pengeluaran;
            $data_pendapatan[] += $pendapatan;

            $tanggal_awal = date('Y-m-d', strtotime("+1 day", strtotime($tanggal_awal)));
        }

        $tanggal_awal = date('Y-m-01');

        return response()->json([
            'status' => true,
            'data' => array(
                'kategori' => $kategori,
                'produk' => $produk,
                'supplier' => $supplier,
                'member' => $member,
                'list_po' => $listpo,
                'list_po1' => $listpo_1,
                'list_po2' => $listpo_2,
                'list_po3' => $listpo_3,
                'list_po4' => $listpo_4,
                'list_po5' => $listpo_5,
                'list_po6' => $listpo_6,
                'penjualan2' => $penjualan2,
                'tanggal' => $data_tanggal,
                'pendapatan' => $data_pendapatan
            )
            // 'user'    => auth()->guard('api')->user(),    
            // 'token'   => $token   
        ], 200);
    }

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
}
