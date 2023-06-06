import 'package:equatable/equatable.dart';

class FoodsModel extends Equatable {
  final String id;
  final String name;
  final String category;
  final String price;
  final String description;
  final String image;

  const FoodsModel({
    required this.id,
    this.name = '',
    this.category = '',
    this.price = '',
    this.description = '',
    this.image = '',
  });

  factory FoodsModel.fromJson(Map<String, dynamic> json) => FoodsModel(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        price: json['price'],
        description: json['description'],
        image: json['image'],
      );

  @override
  List<Object?> get props => [id, name];
}
