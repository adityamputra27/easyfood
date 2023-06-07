import 'package:bloc/bloc.dart';
import 'package:easyfood/models/cart_customers_model.dart';
import 'package:easyfood/services/carts_service.dart';
import 'package:equatable/equatable.dart';

part 'cart_customers_state.dart';

class CartCustomersCubit extends Cubit<CartCustomersState> {
  CartCustomersCubit() : super(CartCustomersInitial());

  void fetchCartCustomers() async {
    try {
      emit(CartCustomersLoading());

      List<CartCustomersModel> cartCustomer =
          await CartsService().fetchCartCustomers();

      emit(CartCustomersSuccess(cartCustomer));
    } catch (e) {
      emit(CartCustomersFailed(e.toString()));
    }
  }
}
