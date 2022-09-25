import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/common/styles/app_styles.dart';
import 'package:test_task/common/widgets/custom_btn.dart';
import 'package:test_task/common/widgets/custom_dialogue.dart';
import 'package:test_task/data_models/field_model.dart';
import 'package:test_task/features/process_page/bloc/process_page_bloc.dart';
import 'package:test_task/features/result_list_page/result_list_page.dart';

class ProcessBodyWidget extends StatelessWidget {
  const ProcessBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProcessPageBloc, ProcessPageState>(
      builder: (context, state) {
        return state.when(
            () => const Center(
                  child: Text(
                    'fetching...',
                    style: AppStyles.textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
            processing: (int numberTask, int taskDataLength) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'calculation on ${numberTask.toString()}',
                        style: AppStyles.textStyle,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10.0),
                          Text(
                            "${(numberTask / taskDataLength) * 100}",
                            style: AppStyles.textStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child: CircularProgressIndicator(
                              value: numberTask / taskDataLength,
                            ),
                          ),
                        ],
                      )),
                      CustomButton(
                        onTapButton: () {
                          context.read<ProcessPageBloc>().add(
                                const SendResultToServer(),
                              );
                        },
                        text: 'Send result to server',
                      ),
                    ],
                  ),
                ),
            errorState: () => const Center(child: CircularProgressIndicator()),
            sending: () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(height: 10.0),
                          Text(
                            "completed",
                            style: AppStyles.textStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.0),
                          SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child: CircularProgressIndicator(
                              value: 1.0,
                            ),
                          ),
                        ],
                      )),
                      CustomButton(
                        onTapButton: () {
                          context.read<ProcessPageBloc>().add(
                                const SendResultToServer(),
                              );
                        },
                        text: 'Send result to server',
                      ),
                    ],
                  ),
                ),
            success: (List<FieldModel> result, List<String> paths) =>
                const Center(child: CircularProgressIndicator()),
            checking: () => const Center(child: CircularProgressIndicator()));
      },
      listener: (context, state) {
        if (state is Error) {
          showDialog(
              context: context,
              builder: (context) {
                return const CustomDialogue(
                  title: 'Task Error',
                  content: 'errorMessage',
                );
              });
        }
        if (state is Success) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResultListPage(
                solvedTasks: state.result,
                results: state.paths,
              ),
            ),
          );
        }
      },
    );
  }
}
