import 'package:equatable/equatable.dart';

class CartsModel extends Equatable {
  final String total;
  final String fullname;

  const CartsModel({
    required this.total,
    required this.fullname,
  });

  factory CartsModel.fromJson(Map<String, dynamic> json) {
    return CartsModel(
      total: json['total'],
      fullname: json['fullname'],
    );
  }

  @override
  List<Object?> get props => [total, fullname];
}
