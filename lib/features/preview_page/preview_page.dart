import 'package:flutter/material.dart';
import 'package:test_task/features/preview_page/widgets/preview_body_widget.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preview screen',
        ),
      ),
      body: PreviewBodyWidget(
        fieldModel: arguments['fieldModel'],
        path: arguments['path'],
      ),
    );
  }
}
