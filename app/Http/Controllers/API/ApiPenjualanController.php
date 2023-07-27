<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Penjualan;
use App\Models\PenjualanDetail;
use App\Models\Produk;
use App\Models\Setting;

class ApiPenjualanController extends Controller
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

    public function show($id_penjualan){

        $penjualan = Penjualan::where('id_penjualan', '=', $id_penjualan);

        return response()->json([
            'result' => true,
            'data' => $penjualan->get(),
            'total_data' => $penjualan->count()
        ]);

    }

    public function menunggu(Request $request){

        if(!$_REQUEST){
            $pesanan_menunggu = Penjualan::where('status', '=', 1)->orderBy('id_penjualan', 'desc')->get();
        }else{
            $search = $_REQUEST['search'];
            $pesanan_menunggu = Penjualan::where('status', '=', 1)
            ->where('id_penjualan', '=', $search)
            ->orWhere('nama_pemesan', 'LIKE', '%'.$search.'%')
            ->orWhere('nama_catalog', 'LIKE', '%'.$search.'%')
            ->orderBy('id_penjualan', 'desc')->get();
        }

        return response()->json([
            'result' => true,
            'data' => $pesanan_menunggu,
            'total_data' => $pesanan_menunggu->count()
        ], 200);

    }

    // public function berjalan(){

    //     if(!$_REQUEST){
    //         $pesanan_berjalan = Penjualan::where('status', '=', 3)->orderBy('id_penjualan', 'desc')->get();
    //     }else{
    //         $search = $_REQUEST['search'];
    //         $pesanan_berjalan = Penjualan::where('status', '=', 3)
    //         ->where('id_penjualan', '=', $search)
    //         ->orWhere('nama_pemesan', 'LIKE', '%'.$search.'%')
    //         ->orWhere('nama_catalog', 'LIKE', '%'.$search.'%')
    //         ->orderBy('id_penjualan', 'desc')->get();
    //     }

    //     // $pesanan_berjalan = Penjualan::where('status', '=', 3)->orderBy('id_penjualan', 'desc')->get();
        
    //     return response()->json([
    //         'result' => true,
    //         'data' => $pesanan_berjalan,
    //         'total_data' => $pesanan_berjalan->count()
    //     ], 200);

    // }

    public function create()
    {
        $penjualan = new Penjualan();
        $penjualan->id_member = null;
        $penjualan->total_item = 0;
        $penjualan->total_harga = 0;
        $penjualan->diskon = 0;
        $penjualan->bayar = 0;
        $penjualan->diterima = 0;
        $penjualan->id_user = auth()->id();
        $penjualan->nama_pemesan = null;
        $penjualan->alamat = null;
        $penjualan->telepon = null;
        $penjualan->harga_bayar = 0;
        $penjualan->sumber_po=null;
        $penjualan->nama_catalog=null;
        $penjualan->keterangan=null;
        $penjualan->status=1;
        $penjualan->save();

        session(['id_penjualan' => $penjualan->id_penjualan]);
        return redirect()->route('transaksi.index');
    }

    public function store(Request $request)
    {
        $penjualan = Penjualan::findOrFail($request->id_penjualan);
        $penjualan->id_member = $request->id_member;
        $penjualan->total_item = $request->total_item;
        $penjualan->total_harga = $request->total;
        $penjualan->diskon = $request->diskon;
        $penjualan->bayar = $request->bayar;
        $penjualan->diterima = $request->diterima;
        $penjualan->nama_pemesan = $request->nama_pemesan;
        $penjualan->alamat = $request->alamat;
        $penjualan->telepon = $request->telepon;
        $penjualan->harga_bayar = $request->harga_bayar;
        $penjualan->sumber_po = $request->sumber_po;
        $penjualan->nama_catalog = $request->nama_catalog;
        $penjualan->keterangan = $request->keterangan;
        $penjualan->update();

        $detail = PenjualanDetail::where('id_penjualan', $penjualan->id_penjualan)->get();
        foreach ($detail as $item) {
            $item->diskon = $request->diskon;
            $item->update();

            $produk = Produk::find($item->id_produk);
            $produk->stok -= $item->jumlah;
            $produk->update();
        }

        return redirect()->route('transaksi.selesai');
    }

    public function destroy($id)
    {
        $penjualan = Penjualan::find($id);
        $detail    = PenjualanDetail::where('id_penjualan', $penjualan->id_penjualan)->get();
        foreach ($detail as $item) {
            $produk = Produk::find($item->id_produk);
            if ($produk) {
                $produk->stok += $item->jumlah;
                $produk->update();
            }

            $item->delete();
        }

        $penjualan->delete();

        return response()->json([
            'status' => true,
            'message' => 'Delete Pesanan Success'
        ], 200);
    }

    public function selesai()
    {
        $setting = Setting::first();

        return view('penjualan.selesai', compact('setting'));
    }

    public function notaKecil()
    {
        $setting = Setting::first();
        $penjualan = Penjualan::find(session('id_penjualan'));
        if (! $penjualan) {
            abort(404);
        }
        $detail = PenjualanDetail::with('produk')
            ->where('id_penjualan', session('id_penjualan'))
            ->get();
        
        return view('penjualan.nota_kecil', compact('setting', 'penjualan', 'detail'));
    }

    public function notaBesar()
    {
        $setting = Setting::first();
        $penjualan = Penjualan::find(session('id_penjualan'));
        if (! $penjualan) {
            abort(404);
        }
        $detail = PenjualanDetail::with('produk')
            ->where('id_penjualan', session('id_penjualan'))
            ->get();

        $pdf = PDF::loadView('penjualan.nota_besar', compact('setting', 'penjualan', 'detail'));
        $pdf->setPaper(0,0,609,440, 'potrait');
        return $pdf->stream('Transaksi-'. date('Y-m-d-his') .'.pdf');
    }

    public function kirim()
    {

    }

}
