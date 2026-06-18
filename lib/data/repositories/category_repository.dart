import 'package:snailywhim/core/services/supabase_services.dart';
import 'package:snailywhim/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

class CategoryRepository {
  final SupabaseClient _supabase = SupabaseServices.client;

  Future<List<CategoryModel>> getAllKategori() async {
    try {
      final response = await _supabase
      .from('kategori')
      .select()
      .order('nama_kategori');
    developer.log('Berhasil mengambil semua kategori', name: 'CategoryRepository');
    return response
      .map<CategoryModel>((json) => CategoryModel.fromJson(json))
      .toList();
    } catch (e) {
      developer.log('Gagal mengambil semua kategori', error: e, name: 'CategoryRepository',);
      throw 'Gagal mengambil data kategori';
    }
  }

  Future<CategoryModel> getKategoriById(String id) async {
    try {
      final response = await _supabase
      .from('kategori')
      .select()
      .eq('id', id)
      .single();
    developer.log('Berhasil mengambil kategori dengan id: $id', name: 'CategoryRepository');
    return CategoryModel.fromJson(response);
    } catch (e) {
      developer.log('Gagal mengambil kategori dengan id: $id', error: e, name: 'CategoryRepository');
      throw 'Kategori tidak ditemukan';
    }
  }

  Future<void> createKategori(String namaKategori) async {
    try {
      await _supabase.from('kategori').insert({'nama_kategori': namaKategori});
      developer.log('Berhasil menambahkan kategori: $namaKategori', name: 'CategoryRepository');
    } catch (e) {
      developer.log('Gagal menambahkan kategori', error: e, name: 'CategoryRepository');
      throw 'Kategori gagal ditambahkan';
    }
  }

  Future<void> updateKategori({
    required String id,
    required String namaKategori,
  }) async {
    try {
      await _supabase
      .from('kategori')
      .update({'nama_kategori': namaKategori})
      .eq('id', id);
    developer.log('Berhasil mengubah kategori: $namaKategori', name: 'CategoryRepository');
    } catch (e) {
      developer.log('Gagal mengubah kategori', error: e, name: 'CategoryRepository');
      throw 'Kategori gagal diubah';
    }
  }

  Future<void> deleteKategori(String id) async {
    try {
      await _supabase
        .from('kategori')
        .delete()
        .eq('id', id);
      developer.log('Berhasil menghapus kategori id: $id', name: 'CategoryRepository');
    } catch (e) {
      developer.log('Gagal menghapus kategori', error: e, name: 'CategoryRepository');
      throw 'Kategori gagal dihapus';
    }
  }
}