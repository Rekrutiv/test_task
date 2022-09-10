
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task/data_models/field_cell_model.dart';
import 'package:test_task/data_models/field_model.dart';

part 'preview_page_event.dart';

part 'preview_page_state.dart';

class PreviewPageBloc extends Bloc<PreviewPageEvent, PreviewPageState> {
  PreviewPageBloc() : super(const PreviewPageState()) {
    on<InitialDataReception>((event, emit) {
      FieldModel fieldModel = event.fieldModel;
      for (FieldCellModel cell in fieldModel.shortestPath) {
        print(cell.cellType);
        if (cell.cellType != CellType.start &&
            cell.cellType != CellType.finish) {
          cell.cellType = CellType.path;
        }
      }
      emit(state.copyWith(
        fieldModel: fieldModel,
        path: event.path,
      ));
    });
  }
}
