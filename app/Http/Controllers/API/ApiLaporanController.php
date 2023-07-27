<?php

namespace App\Http\Controllers\Api;

use App\Models\Pembelian;
use App\Models\Pengeluaran;
use App\Models\Penjualan;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ApiLaporanController extends Controller
{

    public function index(Request $request)
    {
        // var_dump($_REQUEST);
        // print_r($request);
        // exit;
        $awal = $_REQUEST['tanggal_awal'];
        $akhir = $_REQUEST['tanggal_akhir'];
        $no = 1;
        $data = array();
        $pendapatan = 0;
        $total_pendapatan = 0;

        while (strtotime($awal) <= strtotime($akhir)) {
            $tanggal = $awal;
            $awal = date('Y-m-d', strtotime("+1 day", strtotime($awal)));

            $total_penjualan = Penjualan::where('created_at', 'LIKE', "%$tanggal%")->sum('harga_bayar');
            $total_pembelian = Pembelian::where('created_at', 'LIKE', "%$tanggal%")->sum('bayar');
            $total_pengeluaran = Pengeluaran::where('created_at', 'LIKE', "%$tanggal%")->sum('nominal');

            $pendapatan = $total_penjualan - $total_pembelian - $total_pengeluaran;
            $total_pendapatan += $pendapatan;
        }

        return response()->json([
            'success' => true,
            'data' => array(
                'pendapatan' => format_uang($total_pendapatan)
            )
        ], 200);
    }

}
