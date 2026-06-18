import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchCategory extends CategoryEvent{}

class CreateCategory extends CategoryEvent{
  final String namaKategori;
  CreateCategory(this.namaKategori);
  @override
  List<Object?> get props => [namaKategori];
}

class UpdateCategory extends CategoryEvent{
  final String id;
  final String namaKategori;
  UpdateCategory(this.id, this.namaKategori);
  @override
  List<Object?> get props => [id, namaKategori];
}

class DeleteCategory extends CategoryEvent{
  final String id;
  DeleteCategory(this.id);
  @override
  List<Object?> get props => [id];
}