import 'package:bloc/bloc.dart';
import 'package:easyfood/models/tables_model.dart';
import 'package:easyfood/services/tables_service.dart';
import 'package:equatable/equatable.dart';

part 'tables_state.dart';

class TablesCubit extends Cubit<TablesState> {
  TablesCubit() : super(TablesInitial());

  void fetchTables() async {
    try {
      emit(TablesLoading());

      List<TablesModel> tables = await TablesService().fetchTables();

      emit(TablesSuccess(tables));
    } catch (e) {
      emit(TablesFailed(e.toString()));
    }
  }
}
