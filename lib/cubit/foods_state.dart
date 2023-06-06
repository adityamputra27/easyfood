part of 'foods_cubit.dart';

abstract class FoodsState extends Equatable {
  const FoodsState();

  @override
  List<Object> get props => [];
}

class FoodsInitial extends FoodsState {}

class FoodsLoading extends FoodsState {}

class FoodsSuccess extends FoodsState {
  final List<FoodsModel> foods;

  const FoodsSuccess(this.foods);

  @override
  List<Object> get props => [foods];
}

class FoodsFailed extends FoodsState {
  final String error;

  const FoodsFailed(this.error);

  @override
  List<Object> get props => [error];
}
