import 'package:equatable/equatable.dart';
import 'package:snailywhim/data/models/category_model.dart';

abstract class CategoryState extends Equatable{
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState{}

class CategoryLoading extends CategoryState{}

class CategoryLoaded extends CategoryState{
  final List<CategoryModel> catList;
  CategoryLoaded(this.catList);
  @override
  List<Object> get props => [catList];
}

class CategoryError extends CategoryState{
  final String message;
  CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoryCreatedSuccess extends CategoryState{}