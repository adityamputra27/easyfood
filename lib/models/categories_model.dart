import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable {
  final String id;
  final String name;

  const CategoriesModel({
    required this.id,
    this.name = '',
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(id: json['id'], name: json['name']);

  @override
  List<Object?> get props => [id, name];
}
