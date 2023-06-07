import 'package:equatable/equatable.dart';

class CartCustomersModel extends Equatable {
  final String id;
  final String foodsId;
  final String customersId;
  final String quantity;
  final String foodName;
  final String foodImage;

  const CartCustomersModel({
    required this.id,
    required this.foodsId,
    required this.customersId,
    required this.quantity,
    required this.foodName,
    required this.foodImage,
  });

  factory CartCustomersModel.fromJson(Map<String, dynamic> json) {
    return CartCustomersModel(
      id: json['id'],
      foodsId: json['foods_id'],
      customersId: json['customers_id'],
      quantity: json['quantity'],
      foodName: json['food_name'],
      foodImage: json['food_image'],
    );
  }

  @override
  List<Object?> get props =>
      [id, foodsId, customersId, quantity, foodName, foodImage];
}
