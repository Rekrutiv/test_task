import 'package:test_task/data_models/field_cell_model.dart';

class FieldModel {
  final String id;
  final List<List<FieldCellModel>> field;
  List<FieldCellModel> shortestPath = [];

  FieldModel({
    required this.id,
    required this.field,
  });
}