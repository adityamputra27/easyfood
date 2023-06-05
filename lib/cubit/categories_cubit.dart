import 'package:bloc/bloc.dart';
import 'package:easyfood/models/categories_model.dart';
import 'package:easyfood/services/categories_service.dart';
import 'package:equatable/equatable.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void fetchCategories() async {
    try {
      emit(CategoriesLoading());

      List<CategoriesModel> categories =
          await CategoriesService().fetchCategories();

      emit(CategoriesSuccess(categories));
    } catch (e) {
      emit(CategoriesFailed(e.toString()));
    }
  }
}
