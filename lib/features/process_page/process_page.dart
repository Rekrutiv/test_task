import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/process_page/bloc/process_page_bloc.dart';
import 'package:test_task/features/process_page/widgets/process_body_widget.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({Key? key}) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  void initState() {
    Future.microtask(
      () {
        context.read<ProcessPageBloc>().add(
              Initial(),
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
      body: const ProcessBodyWidget(),
    );
  }
}
