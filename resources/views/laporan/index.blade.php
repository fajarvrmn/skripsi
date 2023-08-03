@extends('layouts.master')

@section('title')
    Laporan Pendapatan {{ tanggal_indonesia($tanggalAwal, false) }} s/d {{ tanggal_indonesia($tanggalAkhir, false) }}
@endsection

@push('css')
<link rel="stylesheet" href="{{ asset('/AdminLTE-2/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css') }}">
@endpush

@section('breadcrumb')
    @parent
    <li class="active">Laporan</li>
@endsection

@section('content')
<div class="row">
    <div class="col-lg-12">
        <div class="box">
            <div class="box-header with-border">
                <button onclick="updatePeriode()" class="btn btn-info btn-xs btn-flat"><i class="fa fa-plus-circle"></i> Ubah Periode</button>
                <a href="{{ route('laporan.export_pdf', [$tanggalAwal, $tanggalAkhir]) }}" target="_blank" class="btn btn-success btn-xs btn-flat"><i class="fa fa-file-excel-o"></i> Export PDF</a>
                <button id="btnValidasi" class="btn btn-primary btn-xs btn-flat" style="display: none;"><i class="fa fa-check"></i> Validasi</button>
            </div>
            <div class="box-body table-responsive">
                <table class="table table-stiped table-bordered" id="tblLaporan">
                    <thead>
                        <th width="3%"><input type="checkbox" name="selectAll" id="selectAll"></th>
                        <th width="5%">No</th>
                        <th>Tanggal</th>
                        <th>Total Terjual</th>
                        <th>Penjualan</th>
                        <th>Pembelian</th>
                        <th>Pengeluaran</th>
                        <th>Penggajian</th>
                        <th>Pendapatan Bersih</th>
                        <th>Status Validasi</th>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>

@includeIf('laporan.form')
@endsection

@push('scripts')
<script src="{{ asset('/AdminLTE-2/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js') }}"></script>
<script>
    let table;

    $(function () {
        table = $('.table').DataTable({
            responsive: true,
            processing: true,
            serverSide: true,
            autoWidth: false,
            ajax: {
                url: '{{ route('laporan.data', [$tanggalAwal, $tanggalAkhir]) }}',
            },
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'DT_RowIndex', searchable: false, sortable: false},
                {data: 'tgl_format'},
                {data: 'total_barang'},
                {data: 'penjualan'},
                {data: 'pembelian'},
                {data: 'pengeluaran'},
                {data: 'gaji'},
                {data: 'pendapatan'},
                {data: 'validasi', render: function(data, type, row){
                    if(data == '1') return '<span class="text-primary text-bold"><i class="fa fa-check"></i> Sudah</span> &nbsp; <span class="text-primary">' + row.tanggal_validasi + '</span>'
                    else if(data == '0' && row.total_barang != 0) return '<span class="text-danger text-bold"><i class=""></i> Belum</span>'
                    else if(row.gaji != 'Total Pendapatan') return '<span class="text-muted"><i>Tidak Ada Pembelian<i></span>'
                    else return ''
                }}
            ],
            columnDefs: [{
                'targets': 0,
                'searchable': false,
                'orderable': false,
                'className': 'dt-body-center text-center',
                'render': function (data, type, row, meta){
                    if(row.gaji == 'Total Pendapatan' || row.pembelian == 'Total Terjual All' || row.validasi == '1' || row.total_barang == 0) return '';
                    else return '<input type="checkbox" name="data-'+data+'" value="' + $('<div/>').text(row.tanggal).html() + '">';
                }
            }],
            dom: 'Brt',
            bSort: false,
            bPaginate: false,
        });

        $('.datepicker').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true
        });

        var selectedRows = 0;

        // HANDLE SELECT SINGLE CHECKBOX
        $('#tblLaporan tbody').on('change', 'input[type="checkbox"]', function(){
            if($(this).is(":checked")){
                selectedRows++;
            } else {
                if(selectedRows == 0) selectedRows;
                else selectedRows--;
            }

            if(selectedRows > 0)$("#btnValidasi").show();
            else $("#btnValidasi").hide()
        });

        // HANDLE SELECT ALL CHECKBOX
        $('#selectAll').on('click', function(){
            var rows = table.rows({ 'search': 'applied' }).nodes();
            $('input[type="checkbox"]', rows).prop('checked', this.checked);

            if($('#selectAll').is(':checked')) $("#btnValidasi").show();
            else $("#btnValidasi").hide();

            selectedRows = 0;
        });

        // HANDLE SELECT ALL CHECKBOX
        $('#tblLaporan tbody').on('change', 'input[type="checkbox"]', function(){
            if(!this.checked){
                var el = $('#selectAll').get(0);
                if(el && el.checked && ('indeterminate' in el)){
                    el.indeterminate = true;
                }
            }
        });

        // HANDLE BUTTON VALIDATION
        $('#btnValidasi').on('click', function(e){
            let form = this;
            let listID = [];
            const url = "{{ route('laporan.validasi') }}";

            table.$('input[type="checkbox"]').each(function(){
                if(this.checked){
                    listID.push(this.value);
                }
            });

            $("#btnValidasi").attr('disabled', false);

            let data = listID.join(',')

            if (confirm('Yakin ingin validasi?')) {
                $.post(url, {
                        '_token' : $('[name=csrf-token]').attr('content'),
                        'validasi' : JSON.stringify(data)
                    })
                    .done((res) => {
                        alert('Berhasil Validasi ' + res + ' data')
                        table.ajax.reload();
                    })
                    .fail((errors) => {
                        alert('Gagal Memvalidasi');
                        return;
                    });
            }

            $("#btnValidasi").attr('disabled', false);

        });
    });

    function updatePeriode() {
        $('#modal-form').modal('show');
    }

</script>
@endpush
