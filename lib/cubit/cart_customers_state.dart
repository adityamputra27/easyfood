part of 'cart_customers_cubit.dart';

abstract class CartCustomersState extends Equatable {
  const CartCustomersState();

  @override
  List<Object> get props => [];
}

class CartCustomersInitial extends CartCustomersState {}

class CartCustomersLoading extends CartCustomersState {}

class CartCustomersSuccess extends CartCustomersState {
  final List<CartCustomersModel> cartCustomer;

  const CartCustomersSuccess(this.cartCustomer);

  @override
  List<Object> get props => [cartCustomer];
}

class CartCustomersFailed extends CartCustomersState {
  final String error;

  const CartCustomersFailed(this.error);

  @override
  List<Object> get props => [error];
}
