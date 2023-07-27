<?php

namespace App\Http\Controllers;

use App\Models\Kategori;
use App\Models\Member;
use App\Models\Pembelian;
use App\Models\Pengeluaran;
use App\Models\Penjualan;
use App\Models\Produk;
use App\Models\Supplier;
use App\Models\Listpo;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index()
    {
        $kategori = Kategori::count();
        $produk = Produk::count();
        $supplier = Supplier::count();
        $member = Member::count();
        
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

        if (auth()->user()->level == 1) {
            return view('admin.dashboard', compact('penjualan2', 'kategori','listpo','listpo_1','listpo_2','listpo_3','listpo_4','listpo_5','listpo_6', 'produk', 'supplier', 'member', 'tanggal_awal', 'tanggal_akhir', 'data_tanggal', 'data_pendapatan'));
        } else {
            return view('kasir.dashboard');
        }
    }

    
    
    
    
}
