import 'package:snailywhim/core/services/supabase_services.dart';
import 'package:snailywhim/data/models/cabang_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

class CabangRepository {
  final SupabaseClient _supabase = SupabaseServices.client;
  Future<List<CabangModel>> getAllCabang() async {
    try {
      final response = await _supabase
      .from('cabang')
      .select()
      .order('nama_cabang');
    developer.log('Berhasil mengambil semua cabang', name: 'CabangRepository');
    return response
      .map<CabangModel>((json) => CabangModel.fromJson(json))
      .toList();
    } catch (e) {
      developer.log('Gagal mengambil semua cabang', error: e, name: 'CabangRepository',);
      throw 'Gagal mengambil data cabang';
    }
  }

  Future<CabangModel> getCabangById(String id) async {
    try {
      final response = await _supabase
      .from('cabang')
      .select()
      .eq('id', id)
      .single();
    developer.log('Berhasil mengambil cabang dengan id: $id', name: 'CabangRepository');
    return CabangModel.fromJson(response);
    } catch (e) {
      developer.log('Gagal mengambil cabang dengan id: $id', error: e, name: 'CabangRepository');
      throw 'cabang tidak ditemukan';
    }
  }
}