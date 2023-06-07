import 'package:equatable/equatable.dart';

class TablesModel extends Equatable {
  final String id;
  final String name;

  const TablesModel({
    required this.id,
    this.name = '',
  });

  factory TablesModel.fromJson(Map<String, dynamic> json) =>
      TablesModel(id: json['id'], name: json['name']);

  @override
  List<Object?> get props => [id, name];
}
