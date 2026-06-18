class CabangModel {
  final String id;
  final String nama_cabang;
  final String alamat;
  final String kota;

  CabangModel({
    required this.id,
    required this.nama_cabang,
    required this.alamat,
    required this.kota,
  });

  factory CabangModel.fromJson(Map<String, dynamic> json) {
    return CabangModel(
      id: json['id'],
      nama_cabang: json['nama_cabang'],
      alamat: json['alamat'],
      kota: json['kota'],
    );
  }
}