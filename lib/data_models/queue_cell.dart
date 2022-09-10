import 'package:test_task/data_models/field_cell_model.dart';

class QueueCell {
  List<FieldCellModel> path;
  FieldCellModel fieldCell;

  QueueCell({
    required this.path,
    required this.fieldCell,
  });
}
