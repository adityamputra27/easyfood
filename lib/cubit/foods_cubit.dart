import 'package:bloc/bloc.dart';
import 'package:easyfood/models/foods_model.dart';
import 'package:easyfood/services/foods_service.dart';
import 'package:equatable/equatable.dart';

part 'foods_state.dart';

class FoodsCubit extends Cubit<FoodsState> {
  FoodsCubit() : super(FoodsInitial());

  void fetchFoods() async {
    try {
      emit(FoodsLoading());

      List<FoodsModel> foods = await FoodsService().fetchFoods();

      emit(FoodsSuccess(foods));
    } catch (e) {
      emit(FoodsFailed(e.toString()));
    }
  }
}
