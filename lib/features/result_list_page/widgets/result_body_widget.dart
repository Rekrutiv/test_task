import 'package:flutter/material.dart';
import 'package:test_task/data_models/field_model.dart';
import 'package:test_task/features/result_list_page/widgets/result_tile_widget.dart';

class ResultBodyWidget extends StatelessWidget {
  const ResultBodyWidget(
      {Key? key, required this.solvedTasks, required this.results})
      : super(key: key);
  final List<FieldModel>? solvedTasks;

  final List<String>? results;

  @override
  Widget build(BuildContext context) {
    return solvedTasks != null
        ? ListView.builder(
            itemCount: results!.length,
            itemBuilder: (context, index) {
              return ResultTileWidget(
                fieldModel: solvedTasks![index],
                path: results![index],
              );
            },
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
