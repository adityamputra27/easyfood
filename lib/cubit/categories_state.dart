part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoriesModel> categories;

  const CategoriesSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoriesFailed extends CategoriesState {
  final String error;

  const CategoriesFailed(this.error);

  @override
  List<Object> get props => [error];
}
