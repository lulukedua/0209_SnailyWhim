import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snailywhim/data/models/product_model.dart';
import 'package:snailywhim/data/repositories/product_repository.dart';
import 'package:snailywhim/logic/bloc/product/product_event.dart';
import 'package:snailywhim/logic/bloc/product/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  String _currentKeyword = '';
  final ProductRepository repository;
  List<ProductModel> _allProducts = [];
  String get currentKeyword => _currentKeyword;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await repository.getAllProduct(page: event.page);
        _allProducts = response.productList;
        developer.log(
          'Berhasil mengambil semua data. Total data : ${response.productList.length}',
          name: 'ProductBloc',
        );
        emit(
          ProductLoaded(
            productList: response.productList,
            currentPage: event.page,
            totalPage: response.totalPage,
          ),
        );
      } catch (e) {
        developer.log(
          'Gagal mengambil data: $e',
          name: 'Product Bloc',
          error: e,
        );
        emit(ProductError(e.toString()));
      }
    });

    on<FetchProductById>((event, emit) async {
      emit(ProductLoading());
      try {
        final product = await repository.getProductRawById(event.id);
        developer.log(
          'Berhasil mengambil produk dengan id: $event.id',
          name: 'ProductBloc',
        );
        developer.log('RAW PRODUCT => $product', name: 'ProductBloc');
        emit(
          ProductDetailLoaded(
            product: ProductModel.fromJson(product),
            rawData: product,
          ),
        );
      } catch (e) {
        developer.log(
          'Gagal mengambil produk: $e',
          name: 'Product Bloc',
          error: e,
        );
        emit(ProductError(e.toString()));
      }
    });

    on<CreateProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        await repository.createProduct(event.product);
        developer.log('CreateProduct success', name: 'ProductBloc');
        emit(ProductCreatedSuccess());
        add(FetchProduct());
      } catch (e) {
        developer.log(
          'Gagal menambah produk: $e',
          name: 'Product Bloc',
          error: e,
        );
        emit(ProductError(e.toString()));
      }
    });
    on<UpdateProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        await repository.updateProduct(event.product);
        developer.log('UpdateProduct success', name: 'ProductBloc');
        emit(ProductUpdatedSuccess());
        add(FetchProduct());
      } catch (e) {
        developer.log('Gagal update produk', error: e, name: 'ProductBloc');
        emit(ProductError(e.toString()));
      }
    });
    on<DeleteProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        await repository.deleteProduct(event.id);
        developer.log('DeleteProduct success', name: 'ProductBloc');
        emit(ProductDeletedSuccess());
        add(FetchProduct());
      } catch (e) {
        developer.log('Gagal hapus produk', error: e, name: 'ProductBloc');
        emit(ProductError(e.toString()));
      }
    });
    on<SearchProduct>((event, emit) async {
      emit(ProductLoading());

      try {
        _currentKeyword = event.keyword;

        if (_currentKeyword.trim().isEmpty) {
          final response = await repository.getAllProduct(page: event.page);

          emit(
            ProductLoaded(
              productList: response.productList,
              currentPage: response.currentPage,
              totalPage: response.totalPage,
            ),
          );
          return;
        }

        final response = await repository.searchProduct(
          keyword: _currentKeyword,
          page: event.page,
        );

        emit(
          ProductLoaded(
            productList: response.productList,
            currentPage: response.currentPage,
            totalPage: response.totalPage,
          ),
        );
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<FilterProductByCabang>((event, emit) {
      final filtered = _allProducts.where((product) {
        return product.cabang_id == event.cabangId;
      }).toList();
      emit(ProductLoaded(productList: filtered, currentPage: 1, totalPage: 1));
    });
    on<FilterProductByKategori>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await repository.getProductByKategori(
          kategoriId: event.kategoriId,
          page: event.page,
        );
        emit(
          ProductLoaded(
            productList: response.productList,
            currentPage: response.currentPage,
            totalPage: response.totalPage,
          ),
        );
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
