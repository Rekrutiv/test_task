import 'package:flutter/material.dart';
import 'package:test_task/common/styles/field_cell_colors.dart';

class AppStyles {
  static const textStyle = TextStyle(
    fontSize: 18,
    color:blockedCellColor,
  );

  static final buttonStyle = OutlinedButton.styleFrom(
    textStyle: textStyle,
    minimumSize: const Size.fromHeight(50),
    backgroundColor: Colors.blue.shade300,
    shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side:const BorderSide(
          color: Colors.indigo,
          width: 4,
        )),
    padding: const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 8,
    ),
  );
}
