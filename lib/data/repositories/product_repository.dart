import 'dart:developer' as developer;
import 'dart:io';
import 'package:snailywhim/core/services/supabase_services.dart';
import 'package:snailywhim/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final SupabaseClient _supabase = SupabaseServices.client;
  Future<ProductResponse> getAllProduct({
    required int page,
    int limit = 8,
  }) async {
    final from = (page - 1) * limit;
    final to = from + limit - 1;

    final data = await _supabase
        .from('product')
        .select()
        .order('nama_product')
        .range(from, to);

    final totalData = await _supabase.from('product').select();

    return ProductResponse(
      productList: data
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList(),
      currentPage: page,
      totalPage: (totalData.length / limit).ceil(),
    );
  }

  Future<ProductResponse> searchProduct({
    required String keyword,
    required int page,
  }) async {
    final from = (page - 1) * 8;
    final to = from + 7;

    final data = await _supabase
        .from('product')
        .select()
        .ilike('nama_product', '%$keyword%')
        .range(from, to);

    final total = await _supabase
        .from('product')
        .select()
        .ilike('nama_product', '%$keyword%');

    return ProductResponse(
      productList: data
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList(),
      currentPage: page,
      totalPage: (total.length / 8).ceil(),
    );
  }

  // Future<List<ProductModel>> getAllProduct({
  //   required int page,
  //   int limit = 8,
  // }) async {
  //   try {
  //     final from = page * limit;
  //     final to = from + limit - 1;
  //     final response = await _supabase
  //         .from('product')
  //         .select()
  //         .order('nama_product')
  //         .range(from, to);
  //     developer.log('Berhasil mengambil semua produk', name: 'ProductRepository');
  //     return response
  //         .map<ProductModel>((json) => ProductModel.fromJson(json))
  //         .toList();
  //   } catch (e) {
  //     developer.log(
  //       'Gagal mengambil semua data produk',
  //       error: e,
  //       name: 'ProductRepository',
  //     );
  //     throw 'Gagal mengambil data produk';
  //   }
  // }

  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await _supabase
          .from('product')
          .select('''
            *,
            cabang (
              id,
              nama_cabang
            )
          ''')
          .eq('id', id)
          .single();
      developer.log(
        'Berhasil mengambil data produk: $id',
        name: 'ProductRepository',
      );
      return ProductModel.fromJson(response);
    } catch (e) {
      developer.log(
        'Gagal mengambil data produk: $id',
        error: e,
        name: 'ProductRepository',
      );
      throw 'Produk tidak ditemukan';
    }
  }

  Future<void> createProduct(ProductModel product) async {
    try {
      await _supabase.from('product').insert(product.toJson());
      developer.log(
        'Berhasil menambahkan produk ${product.nama_product}',
        name: 'ProductRepository',
      );
    } catch (e) {
      developer.log(
        'Gagal menambahkan produk',
        error: e,
        name: 'ProductRepository',
      );
      throw 'Gagal menambahkan produk';
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _supabase
          .from('product')
          .update(product.toJson())
          .eq('id', product.id);
      developer.log(
        'Berhasil mengubah data: $product.id',
        name: 'ProductRepository',
      );
    } catch (e) {
      developer.log(
        'Gagal mengubah produk',
        error: e,
        name: 'ProductRepository',
      );
      throw 'Gagal mengubah produk';
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _supabase.from('product').delete().eq('id', id);
      developer.log('Berhasil menghapus data: $id', name: 'ProductRepository');
    } catch (e) {
      developer.log(
        'Gagal menghapus produk',
        error: e,
        name: 'ProductRepository',
      );
      throw 'Gagal menghapus produk';
    }
  }

  Future<String> uploadProductImage(File imageFile) async {
    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
      await _supabase.storage
          .from('product-image')
          .upload(
            fileName,
            imageFile,
            fileOptions: const FileOptions(upsert: false),
          );
      final imageUrl = _supabase.storage
          .from('product-image')
          .getPublicUrl(fileName);
      developer.log(
        'Berhasil upload gambar: $imageUrl',
        name: 'ProductRepository',
      );
      return imageUrl;
    } catch (e) {
      developer.log('Gagal upload gambar', error: e, name: 'ProductRepository');
      throw 'Gagal upload gambar';
    }
  }

  Future<Map<String, dynamic>> getProductRawById(String id) async {
    final response = await _supabase
        .from('product')
        .select('''
        *,
        cabang!product_cabang_id_fkey1(
          id,
          nama_cabang
        )
      ''')
        .eq('id', id)
        .single();
    developer.log('RAW PRODUCT => $response', name: 'ProductRepository');
    return response;
  }

  Future<void> reduceStock({
    required String productId,
    required int qty,
  }) async {
    developer.log(
      'Mengurangi stok produk',
      name: 'ProductRepository',
      error: {'productId': productId, 'qty': qty},
    );
    final product = await Supabase.instance.client
        .from('product')
        .select('stok')
        .eq('id', productId)
        .single();
    final currentStock = product['stok'] as int;
    developer.log('Stok saat ini: $currentStock', name: 'ProductRepository');
    final newStock = currentStock - qty;
    developer.log(
      'Stok setelah dikurangi: $newStock',
      name: 'ProductRepository',
    );

    await Supabase.instance.client
        .from('product')
        .update({'stok': newStock})
        .eq('id', productId);

    developer.log(
      'Berhasil update stok produk',
      name: 'ProductRepository',
      error: {
        'productId': productId,
        'oldStock': currentStock,
        'newStock': newStock,
      },
    );
  }

  Future<ProductResponse> getProductByKategori({
    required String kategoriId,
    required int page,
    int limit = 8,
  }) async {
    final from = (page - 1) * limit;
    final to = from + limit - 1;
 
    final data = await _supabase
        .from('product')
        .select()
        .eq('kategori_id', kategoriId)
        .order('nama_product')
        .range(from, to);
 
    final total = await _supabase
        .from('product')
        .select()
        .eq('kategori_id', kategoriId);
 
    return ProductResponse(
      productList: data
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList(),
      currentPage: page,
      totalPage: (total.length / limit).ceil(),
    );
  }
}
