import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit() : super(CartsInitial());
}
