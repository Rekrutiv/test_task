import 'package:flutter/material.dart';
import 'package:test_task/data_models/field_model.dart';
import 'package:test_task/features/preview_page/widgets/field_visualization_widget.dart';
import 'package:test_task/common/styles/app_styles.dart';

class PreviewBodyWidget extends StatelessWidget {
  const PreviewBodyWidget(
      {Key? key, required this.fieldModel, required this.path})
      : super(key: key);
  final FieldModel fieldModel;
  final String path;

  @override
  Widget build(BuildContext context) {
    return fieldModel.shortestPath.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Expanded(
                child: FieldVisualizationWidget(
                  fieldModel: fieldModel,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  path,
                  style: AppStyles.textStyle,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          );
  }
}
