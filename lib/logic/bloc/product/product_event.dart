import 'package:equatable/equatable.dart';
import 'package:snailywhim/data/models/product_model.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProduct extends ProductEvent {
  final int page;
  FetchProduct({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class FetchProductById extends ProductEvent {
  final String id;
  FetchProductById(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateProduct extends ProductEvent {
  final ProductModel product;
  CreateProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProduct extends ProductEvent {
  final ProductModel product;
  UpdateProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final String id;
  DeleteProduct(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchProduct extends ProductEvent {
  final String keyword;
  final int page;

  SearchProduct(this.keyword, {this.page = 1});
}

class FilterProductByCabang extends ProductEvent {
  final String cabangId;
  FilterProductByCabang(this.cabangId);

  @override
  List<Object?> get props => [cabangId];
}

class FilterProductByKategori extends ProductEvent {
  final String kategoriId;
  final int page;
  FilterProductByKategori(this.kategoriId, {this.page = 1});

  @override
  List<Object?> get props => [kategoriId, page];
}
