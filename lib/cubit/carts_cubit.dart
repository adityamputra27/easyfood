import 'package:bloc/bloc.dart';
import 'package:easyfood/models/carts_model.dart';
import 'package:easyfood/services/carts_service.dart';
import 'package:equatable/equatable.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit() : super(CartsInitial());

  void fetchCountCarts() async {
    try {
      emit(CartsLoading());

      CartsModel carts = await CartsService().fetchCountCarts();

      emit(CartsSuccess(carts));
    } catch (e) {
      emit(CartsFailed(e.toString()));
    }
  }
}
