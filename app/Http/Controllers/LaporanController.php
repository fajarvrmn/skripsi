<?php

namespace App\Http\Controllers;

use App\Models\Pembelian;
use App\Models\Pengeluaran;
use App\Models\Penjualan;
use App\Models\Gaji;
use Illuminate\Http\Request;
use PDF;

class LaporanController extends Controller
{
    public function index(Request $request)
    {
        $tanggalAwal = date('Y-m-d', mktime(0, 0, 0, date('m'), 1, date('Y')));
        $tanggalAkhir = date('Y-m-d');

        if ($request->has('tanggal_awal') && $request->tanggal_awal != "" && $request->has('tanggal_akhir') && $request->tanggal_akhir) {
            $tanggalAwal = $request->tanggal_awal;
            $tanggalAkhir = $request->tanggal_akhir;
        }

        return view('laporan.index', compact('tanggalAwal', 'tanggalAkhir'));
    }

    public function getData($awal, $akhir)
    {
        $no = 1;
        $data = array();
        $pendapatan = 0;
        $total_pendapatan = 0;

        while (strtotime($awal) <= strtotime($akhir)) {
            $tanggal = $awal;
            $awal = date('Y-m-d', strtotime("+1 day", strtotime($awal)));

            $total_barang = Penjualan::where('created_at', 'LIKE', "%$tanggal%")->count('*');
            $total_penjualan = Penjualan::where('created_at', 'LIKE', "%$tanggal%")->sum('harga_bayar');
            $total_pembelian = Pembelian::where('created_at', 'LIKE', "%$tanggal%")->sum('bayar');
            $total_pengeluaran = Pengeluaran::where('created_at', 'LIKE', "%$tanggal%")->sum('nominal');
            $total_gaji = Gaji::where('created_at', 'LIKE', "%$tanggal%")->sum('total');

            $validasi = Penjualan::where('created_at', 'LIKE', "%$tanggal%")->where('flag_validasi', 1)->first();
            $tgl_validasi = (isset($validasi)) ? tanggal_indonesia($validasi->tgl_validasi, false) : '';
            $flag_validasi = (isset($validasi)) ? '1' : '0';

            $pendapatan = $total_penjualan - $total_pembelian - $total_pengeluaran - $total_gaji;
            $total_pendapatan += $pendapatan;

            $row = array();
            $row['DT_RowIndex'] = $no++;
            $row['tgl_format'] = tanggal_indonesia($tanggal, false);
            $row['total_barang'] = $total_barang;
            $row['penjualan'] = format_uang($total_penjualan);
            $row['pembelian'] = format_uang($total_pembelian);
            $row['pengeluaran'] = format_uang($total_pengeluaran);
            $row['gaji'] = format_uang($total_gaji);
            $row['pendapatan'] = format_uang($pendapatan);
            $row['tanggal'] = $tanggal;
            $row['validasi'] = $flag_validasi;
            $row['tanggal_validasi'] = $tgl_validasi;

            $data[] = $row;
        }

        $data[] = [
            'DT_RowIndex' => '',
            'total_barang'=> '',
            'tgl_format' => '',
            'penjualan' => '',
            'pembelian' => 'Total Terjual All',
            'pengeluaran' => format_uang($total_pengeluaran),
            'pendapatan' => format_uang($total_pendapatan),
            'gaji' => 'Total Pendapatan',
            'tanggal' => '',
            'validasi' => '',
            'tanggal_validasi' => '',
        ];

        return $data;
    }

    public function data($awal, $akhir)
    {
        $data = $this->getData($awal, $akhir);

        return datatables()
            ->of($data)
            ->make(true);
    }

    public function exportPDF($awal, $akhir)
    {
        $data = $this->getData($awal, $akhir);
        $pdf  = PDF::loadView('laporan.pdf', compact('awal', 'akhir', 'data'));
        $pdf->setPaper('a4', 'potrait');

        return $pdf->stream('Laporan-pendapatan-'. date('Y-m-d-his') .'.pdf');
    }

    public function validasi(Request $request)
    {
        $list_tgl = explode(',', json_decode($request->validasi));
        $success = 0;

        foreach ($list_tgl as $tgl) {
            $data = Penjualan::whereRaw("DATE(created_at) LIKE ?", [$tgl])->update([
                'flag_validasi' => 1,
                'tgl_validasi' => now(),
                'user_validasi' => auth()->user()->name,
            ]);
            $success++;
        }

        if(!$data && $success == 0) return false;
        return $success;
    }
}
