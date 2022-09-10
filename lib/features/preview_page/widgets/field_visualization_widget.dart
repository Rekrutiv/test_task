import 'package:flutter/material.dart';
import 'package:test_task/common/styles/field_cell_colors.dart';
import 'package:test_task/data_models/field_cell_model.dart';
import 'package:test_task/data_models/field_model.dart';

class FieldVisualizationWidget extends StatelessWidget {
  final FieldModel fieldModel;
  final double width;

  const FieldVisualizationWidget({
    Key? key,
    required this.fieldModel,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildGrid(),
    );
  }

  List<Widget> _buildGrid() {
    List<Widget> rows = [];
    for (int i = 0; i < fieldModel.field.length; i++) {
      rows.add(_buildRow(fieldModel.field[i]));
    }
    return rows;
  }

  Widget _buildRow(List<FieldCellModel> row) {
    return Row(
      children: _buildCells(row),
    );
  }

  List<Widget> _buildCells(List<FieldCellModel> row) {
    List<Widget> cells = [];
    for (int i = 0; i < row.length; i++) {
      FieldCellModel currentCell = row[i];
      print(row[i].cellType);

      cells.add(
        Container(
          height: width / fieldModel.field.length,
          width: width / row.length,
          decoration: BoxDecoration(
            color: _chooseCellColor(
              currentCell.cellType,
            ),
            border: Border.all(),
          ),
          child: Center(
            child: Text(
              '(${currentCell.xCoordinate},${currentCell.yCoordinate})',
              style: TextStyle(
                fontSize: 22,
                color: currentCell.cellType == CellType.blocked
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      );
    }
    return cells;
  }

  Color _chooseCellColor(CellType type) {
    late Color cellColor;
    switch (type) {
      case CellType.start:
        cellColor = startCellColor;
        break;
      case CellType.finish:
        cellColor = finishCellColor;
        break;
      case CellType.empty:
        cellColor = emptyCellColor;
        break;
      case CellType.blocked:
        cellColor = blockedCellColor;
        break;
      case CellType.path:
        cellColor = pathCellColor;
        break;
    }

    return cellColor;
  }
}
