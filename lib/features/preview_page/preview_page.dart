import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/preview_page/bloc/preview_page_bloc.dart';
import 'package:test_task/features/preview_page/widgets/preview_body_widget.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  void initState() {
    Future.microtask(
      () {
        Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
        context.read<PreviewPageBloc>().add(
              InitialDataReception(
                fieldModel: arguments['fieldModel'],
                path: arguments['path'],
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
          'Preview screen',
        ),
      ),
      body: const PreviewBodyWidget(),
    );
  }
}
