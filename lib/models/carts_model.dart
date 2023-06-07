import 'package:equatable/equatable.dart';

class CartsModel extends Equatable {
  final String total;
  final String fullname;
  final List carts;

  const CartsModel({
    required this.total,
    required this.fullname,
    required this.carts,
  });

  factory CartsModel.fromJson(Map<String, dynamic> json) {
    return CartsModel(
      total: json['total'],
      fullname: json['fullname'],
      carts: json['carts'],
    );
  }

  @override
  List<Object?> get props => [total, fullname, carts];
}
