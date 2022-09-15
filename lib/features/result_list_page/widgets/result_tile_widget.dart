import 'package:flutter/material.dart';
import 'package:test_task/data_models/field_model.dart';
import 'package:test_task/common/styles/app_styles.dart';

import '../../../data_models/field_cell_model.dart';

class ResultTileWidget extends StatelessWidget {
  final FieldModel fieldModel;
  final String path;

  const ResultTileWidget({
    Key? key,
    required this.fieldModel,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FieldModel solution = fieldModel;

    return GestureDetector(
      onTap: () {
        for (FieldCellModel cell in solution.shortestPath) {
          if (cell.cellType != CellType.start &&
              cell.cellType != CellType.finish) {
            cell.cellType = CellType.path;
          }
        }
        Navigator.pushNamed(
          context,
          '/preview',
          arguments: {
            'path': path,
            'fieldModel': solution,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: Text(
          path,
          style: AppStyles.textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
