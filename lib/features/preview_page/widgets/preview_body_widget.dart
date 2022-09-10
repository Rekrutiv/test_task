import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/preview_page/bloc/preview_page_bloc.dart';
import 'package:test_task/features/preview_page/widgets/field_visualization_widget.dart';
import 'package:test_task/common/styles/app_styles.dart';

class PreviewBodyWidget extends StatelessWidget {
  const PreviewBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewPageBloc, PreviewPageState>(
      builder: (context, state) {
        if (state.fieldModel == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                child: FieldVisualizationWidget(
                  fieldModel: state.fieldModel!,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  state.path!,
                  style: AppStyles.textStyle,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
