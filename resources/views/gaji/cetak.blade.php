<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Slip Gaji</title>

    <style type="text/css">
        * {
            box-sizing: border-box;
            font-family: 'Times New Roman', Times, serif;
            /* border: 0.1px solid red; */
        }

        @page {
            margin: 0;
        }

        .container {
            /* position: absolute;
            top: -40px;
            left: -40px; */
            /* right: -40px; */
            /* bottom: -40px; */
            /* padding: 0 20px; */
            border: 2px solid #605ca7;
            background: #eceaea;
            height: 99%;
        }
        .box-title {
            /* position: absolute;
            top: 30px;
            left: 0; */
            width: 200px;
            /* height: 50px; */
            background: #605ca7;
            color: #fff;
            padding: 20px;
            margin-top: 60px;
            border-radius: 0px 50% 50% 0;
        }
        .title {
            /* position: absolute;
            left: 20%;
            top: -10%; */
            /* width: 200px; */
            /* height: 50px; */
            color: #fff;
            font-size: 34px;
            padding: 0;
            margin: 0;
            font-weight: bold;
        }
        .title-bulan {
            /* position: absolute;
            left: 20%;
            top: 30%; */
            /* width: 200px; */
            /* height: 50px; */
            color: #fff;    
            padding: 0;
            margin: 0;
            font-size: 20px;
            font-weight: bold;
        }

        .logo {
            position: absolute;
            top: 75px;
            right: 30px;
            width: 80px;
            height: 80px;
            background: #605ca7;
            color: #fff;
            border-radius: 50%;
        }

        .top-text {
            /* position: absolute;
            top: 150px;
            left: 30%; */
            margin-top: 24px;
            font-size: 12px;
            text-align: center;
            width: 100%;
            /* height: 50px; */
            color: #423cb7
        }

        .top-text p {
            margin: 0;
            padding: 0;
        }

        .top-text p:first-child {
            text-transform: uppercase;
            margin-bottom: 15px;
        }

        .top-text p:nth-child(2) {
            text-transform:capitalize
        }

        .top-text h4 {
            text-transform: uppercase;
            font-size: 14px;
        }

        .wrap-table {
            width: 100%;
        }

        .table {
            /* position: absolute; */
            /* top: 280px; */
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
        }

        .table, th, td {
            border: 1px solid #423cb7;
        }

        .table thead {
            
            background: #605ca7;
            color: #fff;
        }

        .bottom-text {
            /* position: absolute; */
            /* top: 550px; */
            /* left: 25%; */
            font-size: 12px;
            text-align: center;
            width: 270px;
            color: #000;
            margin: 20px auto;
        }

        .signature {
            /* position: absolute;
            bottom: -20px;
            left: 25%; */
            font-size: 12px;
            text-align: center;
            width: 270px;
            color: #000;
            margin: 40px auto 0 auto;
        }

        .bottom-side {
            position: absolute;
            bottom: 7px;
            right: 0;
            width: 60%;
            height: 15px;
            background: #605ca7;
            color: #fff;
            padding: 20px;
            border-radius: 50% 0 0 0;
            z-index: -99;
        }

        th, td {
            padding: 10px;
        }

        th {
            text-align: left;
            font-size: 12px;
        }

        td {
            font-size: 11px;
            background: #fff
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="box-title">
            <h1 class="title">Slip Gaji</h1>
            <h4 class="title-bulan">Bulan {{ $bulan }}</h4>
        </div>
        <img src="{{ public_path('img/logo-20230410041830.png') }}" alt="" class="logo">
        <div class="top-text">
            <p>Kepada</p>
            <p>{{ $pegawai->name }}</p>
            <p>{{ $pegawai->no_telp }}</p>
            <p>{{ $pegawai->alamat }}</p>
            <h4>Rincian Pekerjaan</h4>
        </div>
        <div class="wrap-table">
            <table class="table">
                <thead class="table-head" >
                    <tr>
                        <th>No</th>
                        <th>Kode PO</th>
                        <th>Tanggal Selesai</th>
                        <th>Pokok</th>
                        <th>Bonus</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    @php
                        $total = 0;
                    @endphp
                    @foreach ($gaji as $item)
                    @php
                        $total += $item->total;
                    @endphp
                    <tr>
                        <td>{{ $loop->iteration }}</td>
                        <td>{{ $item->kode }}</td>
                        <td>{{ date('d M Y', strtotime($item->selesai)) }}</td>
                        <td>Rp{{ number_format($item->harga, 0, ',', '.') }}</td>
                        <td>Rp{{ number_format($item->bonus, 0, ',', '.') }}</td>
                        <td>Rp{{ number_format($item->total, 0, ',', '.') }}</td>
                    </tr>
                    @php
                        
                    @endphp
                    @endforeach
                    <tr>
                        <td colspan="5" style="text-align: center; font-weight: bold">Total Gaji</td>
                        <td style="font-weight: bold;">Rp{{ number_format($total, 0, ',', '.') }}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <p class="bottom-text">
            Pembayaran ini meliputi gaji untuk satu bulan penuh bekerja, adapun jika terjadi kesalahan bisa menghubungi pihak dari Wangi Project
            <br />
            Terima kasih sudah bekerja sama
        </p>
        <p class="signature">Wildan Abdul Aziz</p>
        <div class="bottom-side"></div>
        </div>
    </div>

</body>
</html>
