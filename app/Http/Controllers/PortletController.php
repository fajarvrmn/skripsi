<?php

namespace App\Http\Controllers;

use App\Models\Produk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PortletController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('portlet.index');
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
    
    public function data(Request $request)
    {
        // TAMPUNG REQUEST INPUT
        $kode_produk = trim($request->kode_produk);
        $nama_produk = trim($request->nama_produk);

        // JIKA KODE PRODUK TIDAK KOSONG MAKA GUNAKAN KODE PRODUK, JIKA KOSONG MAKA GUNAKAN NAMA PRODUK
        $value = ($kode_produk != '' ? $kode_produk : $nama_produk);

        // INISIALISASI VARIABLE
        $stok = $produk =  []; 
        $field = '';

        // JIKA KODE PRODUK TIDAK KOSONG MAKA CARI PRODUK BERDASARKAN KODE PRODUK
        if($kode_produk != '') {
            $field = 'kode_produk';
            // MENGAMBIL SEMUA KODE PRODUK DALAM BENTUK ARRAY
            $produk = Produk::pluck($field)->toArray();

            // GET DATA BERDASARKAN NAMA PRODUK
            $stok = Produk::select(DB::Raw('produk.kode_produk as kode_produk, kategori.nama_kategori as nama_kategori, produk.nama_produk as nama_produk, produk.harga_beli as harga_beli, produk.stok as stok'))->where('kode_produk', $kode_produk)
            ->join('kategori', 'kategori.id_kategori', '=', 'produk.id_kategori')
            ->first();

        // CARI PRODUK BERDASARKAN NAMA PRODUK
        } else {
            $field = 'nama_produk';
            // MENGAMBIL SEMUA NAMA PRODUK DALAM BENTUK ARRAY
            $produk = Produk::pluck($field)->toArray();

            // GET DATA BERDASARKAN NAMA PRODUK
            $stok = Produk::select(DB::Raw('produk.kode_produk as kode_produk, kategori.nama_kategori as nama_kategori, produk.nama_produk as nama_produk, produk.harga_beli as harga_beli, produk.stok as stok'))
            ->join('kategori', 'kategori.id_kategori', '=', 'produk.id_kategori')
            ->where($field, 'like' , '%' . $nama_produk . '%')
            ->orderBy('nama_produk', 'ASC')->get();
        } 

        // JIKA FIELDNYA KODE_PRODUK, MAKA DATA STOK TAMPUNG DI DALAM ARRAY
        if($field == 'kode_produk') $stok =  [$stok];

        $data = [
            'data' => $stok,
            // JALANKAN FUNGSI LINEAR SEARCH
            'status' => $this->linear_search($produk, $value, $field)
        ];        
        
        return response()->json($data);
    }

    private function linear_search($data, $value, $field)
    {
        $i = 0;
        $msg = '';
        $total = 0;
        $result = false;

        // START MICROTIME 
        $start = microtime(true);

        // LOOPING DATA PRODUK ( KODE PRODUK | NAMA PRODUK )
        for ($i=0; $i < count($data); $i++) { 

            // JIKA DATA BERDASARKAN KODE PRODUK
            if($field == 'kode_produk'){
                // JIKA DATA DITEMUKAN MAKA BREAK KE END MICRO TIME
                if($data[$i] == $value){
                    $msg = "Kode produk $data[$i] di temukan";
                    $result = true;
                    break;
                }
            // JIKA DATA BERDASARKAN NAMA PRODUK
            } else {
                // JIKA DATA MENGANDUNG KATA YANG DICARI MAKA, 
                // TAMBAH TOTAL DATA YANG MENGANGUNG KATA YANG DICARI
                if(str_contains($data[$i], $value)){
                    $total++;
                    $result = true;
                }
                $msg = "$total produk dengan nama $value di temukan";
            }
        }
        
        // END MICRO TIME
        $end = microtime(true);

        // FORMAT WAKTU
        $estTime = substr(($end - $start), 0,5); 

        // JIKA DATA TIDAK DITEMUKAN
        if(!$result) {
            if($field == 'kode_produk') $msg = "Kode produk $value tidak ditemukan";
            else $msg = "Produk dengan nama  $value tidak ditemukan";
        }

        return [
            'result' => $result,
            'msg' => $msg,
            'time' => "Waktu yang dibutuhkan: " . ($estTime)  . " detik"
        ];
    }
}