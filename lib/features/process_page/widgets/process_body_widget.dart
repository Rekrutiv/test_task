import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/common/widgets/custom_btn.dart';
import 'package:test_task/features/process_page/bloc/process_page_bloc.dart';
import 'package:test_task/features/process_page/widgets/progress_display_widget.dart';

class ProcessBodyWidget extends StatelessWidget {
  const ProcessBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessPageBloc, ProcessPageState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ProgressDisplayWidget(
                  loadProgress: state,
                ),
              ),
              _buildButtonSection(
                context,
                state,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonSection(BuildContext context, ProcessPageState state) {
    if (state.progressStage == ProgressStage.result) {
      return CustomButton(
        onTapButton: () {
          context.read<ProcessPageBloc>().add(
                SendResultToServer(),
              );
        },
        text: 'Send result to server',
      );
    } else if (state.progressStage == ProgressStage.sending) {
      return const CircularProgressIndicator();
    } else {
      return const SizedBox(
        height: 200,
      );
    }
  }
}
