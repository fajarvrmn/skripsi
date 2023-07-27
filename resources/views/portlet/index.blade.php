@extends('layouts.portletLayout')

@section('portlet')
<div class="login-box">
    <div class="login-box-body">
        <div class="col-xs-12">
            <h3 align="center">
                <label>
                    Portal Cek Stok
                </label>
                <label style="font-size: 10pt;">Pilih kata kunci yang akan dicari</label>
            </h3>
        </div>
        <br>
        <div class="form-check form-check-inline">
            <input type="radio" name="input-type" value="kode_produk" id="input-kode" class="form-check-input" checked>
            <label for="input-kode" class="form-check-label">
                Kode
            </label>
            &nbsp;&nbsp;&nbsp;
            <input type="radio" name="input-type" value="nama_produk" id="input-nama" class="form-check-input">
            <label for="input-nama" class="form-check-label">
                Nama
            </label>
        </div>
        <form action="" method="" id="form-portlet" name="form-portlet">
            <div class="form-group">
                <input type="text" id="kode_produk" name="kode_produk" class="form-control" placeholder="Ex : P00006">
            </div>
            <div class="form-group">
                <input type="text" id="nama_produk" name="nama_produk" class="form-control" placeholder="Ex : Bunga" disabled>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <button type="button" class="btn btn-primary btn-block btn-flat" id="btn-cari">Cari</button>
                </div>
            </div>
            <a href="/">Kembali</a>
        </form>
    </div>
</div>
@include('portlet.view_data')
@endsection


@push('scripts')
<script type="text/javascript">
    $(document).ready(function() {
        $("input[name='input-type']").change(function(e) {
            if($('#kode_produk').is('[disabled=disabled]')){
                $('#kode_produk').attr('disabled', false);
                $('#nama_produk').attr('disabled', true);
                //reset val
                $('#kode_produk').val('');
                $('#nama_produk').val('');
            } else {
                $('#kode_produk').attr('disabled', true);
                $('#nama_produk').attr('disabled', false);
                //reset val
                $('#nama_produk').val('');
                $('#kode_produk').val('');
            }
        });

        $('#btn-cari').click(function(e){
            $('#view_data').hide();
            $('#view_data .box').hide();

            var kode_produk = $('#kode_produk').val(); 
            var nama_produk = $('#nama_produk').val();

            if($('#nama_produk').prop('disabled') && kode_produk == ''){
                alert('Masukkan Kode Produk');
                $('#kode_produk').focus();
                return;
            }

            if($('#kode_produk').prop('disabled') && nama_produk == ''){
                alert('Masukkan Nama Produk');
                $('#nama_produk').focus();
                return;
            }

            var url = `{{ url('/portlet/data') }}`;

            $.get(url,{kode_produk:kode_produk,nama_produk:nama_produk})

                .done((response) => {
                    var data = response.data;
                    var time = response.status.time;
                    var msg = response.status.msg;
                    var html = '';
                    var no = 1;

                    if(data && data.length != 0 && data[0] != null){
                        data.forEach(res => {

             
                            let s = ""

                            if(res.stok<=3){
                                 s = "style=\"background-color:red\"";
                            }
                            html += `<tr `+s+`>
                                        <td id="no">${no}</td>
                                        <td id="kode_produk">${res.kode_produk}</td>
                                        <td id="nama_kategori">${res.nama_kategori}</td>
                                        <td id="nama_produk">${res.nama_produk}</td>
                                        <td id="stok">${res.stok}</td>
                                        <td id="harga_beli">${res.harga_beli}</td>
                                    </tr>`;
                            no++;

                        });

                        $('#row-stok').html(html);

                        $('#view_data #message').html(msg + '. ' + time);
                        $('#view_data').show();
                        $('#view_data .box').show();
                    } else {
                        $('#view_data #message').html(msg);
                        $('#view_data').show();
                        $('#view_data .box').hide();
                    }
                    
                })
                .fail((err) => {
                    return err.msg
                });


        })
    });
</script>
@endpush

    
