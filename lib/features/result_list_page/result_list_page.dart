import 'package:flutter/material.dart';
import 'package:test_task/data_models/field_model.dart';
import 'package:test_task/features/result_list_page/widgets/result_body_widget.dart';

class ResultListPage extends StatelessWidget {
  const ResultListPage({Key? key, required this.solvedTasks,required this.results}) : super(key: key);

  final List<FieldModel> solvedTasks;

  final  List<String> results;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result list screen',
        ),
      ),
      body:  ResultBodyWidget(solvedTasks: solvedTasks, results: results,),
    );
  }
}
