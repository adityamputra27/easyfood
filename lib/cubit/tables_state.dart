part of 'tables_cubit.dart';

abstract class TablesState extends Equatable {
  const TablesState();

  @override
  List<Object> get props => [];
}

class TablesInitial extends TablesState {}

class TablesLoading extends TablesState {}

class TablesSuccess extends TablesState {
  final List<TablesModel> tables;

  const TablesSuccess(this.tables);

  @override
  List<Object> get props => [tables];
}

class TablesFailed extends TablesState {
  final String error;

  const TablesFailed(this.error);

  @override
  List<Object> get props => [error];
}
