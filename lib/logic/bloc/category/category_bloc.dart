import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snailywhim/data/repositories/category_repository.dart';
import 'package:snailywhim/logic/bloc/category/category_event.dart';
import 'package:snailywhim/logic/bloc/category/category_state.dart';
import 'dart:developer' as developer;

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({required this.repository}) : super(CategoryInitial()) {
    on<FetchCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        final list = await repository.getAllKategori();
        developer.log(
          'FetchCategory success. Total data: ${list.length}',
          name: 'CategoryBloc',
        );
        emit(CategoryLoaded(list));
      } catch (e) {
        developer.log(
          'FetchCategory failed: $e',
          name: 'CategoryBloc',
          error: e,
        );
        emit(CategoryError(e.toString()));
      }
    });
    on<CreateCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await repository.createKategori(event.namaKategori);
        developer.log('CreateCategory success', name: 'CategoryBloc');
        emit(CategoryCreatedSuccess());
        add(FetchCategory());
      } catch (e) {
        developer.log(
          'CreateCategory failed: $e',
          name: 'CategoryBloc',
          error: e,
        );
        emit(CategoryError(e.toString()));
      }
    });
    on<UpdateCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await repository.updateKategori(
          id: event.id,
          namaKategori: event.namaKategori,
        );
        developer.log('UpdateCategory success', name: 'CategoryBloc');
        emit(CategoryCreatedSuccess());
        add(FetchCategory());
      } catch (e) {
        developer.log(
          'UpdateCategory failed: $e',
          name: 'CategoryBloc',
          error: e,
        );
        emit(CategoryError(e.toString()));
      }
    });
    on<DeleteCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await repository.deleteKategori(event.id);
        developer.log('DeleteCategory success', name: 'CategoryBloc');
        emit(CategoryCreatedSuccess());
        add(FetchCategory());
      } catch (e) {
        developer.log(
          'DeleteCategory failed: $e',
          name: 'CategoryBloc',
          error: e,
        );
        emit(CategoryError(e.toString()));
      }
    });
  }
}
