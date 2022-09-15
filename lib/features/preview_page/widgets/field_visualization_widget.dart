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
    List<FieldCellModel> listCell = [];
    for (int i = 0; i < fieldModel.field.length; i++) {
      for (int j = 0; j < fieldModel.field[i].length; j++) {
        listCell.add(fieldModel.field[i][j]);
      }
    }

    return GridView.builder(
        itemCount: listCell.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: fieldModel.field.length,
        ),
        itemBuilder: (context, index) {
          return Container(
            height: width / fieldModel.field.first.length,
            width: width / fieldModel.field.first.length,
            decoration: BoxDecoration(
              color: _chooseCellColor(
                listCell[index].cellType,
              ),
              border: Border.all(),
            ),
            child: Center(
              child: Text(
                '(${listCell[index].xCoordinate},${listCell[index].yCoordinate})',
                style: TextStyle(
                  fontSize: 22,
                  color: listCell[index].cellType == CellType.blocked
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          );
        });
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
