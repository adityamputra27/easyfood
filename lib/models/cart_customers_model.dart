import 'package:equatable/equatable.dart';

class CartCustomersModel extends Equatable {
  final String id;
  final String foodsId;
  final String customersId;
  final String quantity;
  final String foodName;
  final String foodImage;
  final String foodPrice;

  const CartCustomersModel({
    required this.id,
    required this.foodsId,
    required this.customersId,
    required this.quantity,
    required this.foodName,
    required this.foodImage,
    required this.foodPrice,
  });

  factory CartCustomersModel.fromJson(Map<String, dynamic> json) {
    return CartCustomersModel(
      id: json['id'],
      foodsId: json['foods_id'],
      customersId: json['customers_id'],
      quantity: json['quantity'],
      foodName: json['food_name'],
      foodImage: json['food_image'],
      foodPrice: json['food_price'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'foods_id': foodsId,
        'customers_id': customersId,
        'quantity': quantity,
        'food_name': foodName,
        'food_image': foodImage,
        'food_price': foodPrice,
      };

  @override
  List<Object?> get props =>
      [id, foodsId, customersId, quantity, foodName, foodImage, foodPrice];
}
