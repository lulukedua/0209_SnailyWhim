import 'package:equatable/equatable.dart';
import 'package:snailywhim/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> productList;
  final int currentPage;
  final int totalPage;

  ProductLoaded({
    required this.productList,
    required this.currentPage,
    required this.totalPage,
  });

  @override
  List<Object> get props => [productList, currentPage, totalPage];
}

class ProductDetailLoaded extends ProductState {
  final ProductModel product;
  final Map<String, dynamic> rawData;
  ProductDetailLoaded({required this.product, required this.rawData});

  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductCreatedSuccess extends ProductState {}

class ProductUpdatedSuccess extends ProductState {}

class ProductDeletedSuccess extends ProductState {}
