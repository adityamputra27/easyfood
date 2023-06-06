part of 'carts_cubit.dart';

abstract class CartsState extends Equatable {
  const CartsState();

  @override
  List<Object> get props => [];
}

class CartsInitial extends CartsState {}

class CartsLoading extends CartsState {}

class CartsSuccess extends CartsState {
  final CartsModel carts;

  const CartsSuccess(this.carts);

  @override
  List<Object> get props => [carts];
}

class CartsFailed extends CartsState {
  final String error;

  const CartsFailed(this.error);

  @override
  List<Object> get props => [error];
}
