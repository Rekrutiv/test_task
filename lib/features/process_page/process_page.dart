import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/common/widgets/custom_dialogue.dart';
import 'package:test_task/features/process_page/bloc/process_page_bloc.dart';
import 'package:test_task/features/process_page/widgets/process_body_widget.dart';
import 'package:test_task/features/result_list_page/result_list_page.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({Key? key}) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  late String errorMessage;

  @override
  void initState() {
    Future.microtask(
      () {
        Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        context.read<ProcessPageBloc>().add(
              FetchInitialData(
                url: arguments['submittedUrl']!,
              ),
            );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Process screen',
        ),
      ),
      body: BlocListener<ProcessPageBloc, ProcessPageState>(
        listener: (context, state) {
          if (state.progressStage == ProgressStage.fail) {
            errorMessage = 'error' ;
            showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogue(
                    title: 'Task Error',
                    content: errorMessage,
                  );
                });
          } else if (state.progressStage == ProgressStage.success) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ResultListPage(
                  solvedTasks: state.solvedTasks ?? [],
                  results: state.results ?? [],
                ),
              ),
            );
          }
        },
        child: const ProcessBodyWidget(),
      ),
    );
  }
}
