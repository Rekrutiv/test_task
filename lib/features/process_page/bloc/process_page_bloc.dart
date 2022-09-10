import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task/data_models/field_cell_model.dart';
import 'package:test_task/data_models/field_model.dart';
import 'package:test_task/data_models/task_data.dart';
import 'package:test_task/networking/webspark_client.dart';
import 'package:test_task/utils/task_solver.dart';

part 'process_page_event.dart';

part 'process_page_state.dart';

class ProcessPageBloc extends Bloc<ProcessPageEvent, ProcessPageState> {
  final WebSparkClient webSparkClient = WebSparkClient();

  ProcessPageBloc() : super(const ProcessPageState()) {
    on<FetchInitialData>((event, emit) async {
      List<TaskData>? tasksData = await webSparkClient.fetchTasks(event.url);
      if (tasksData != null) {
        emit(state.copyWith(
          progressMessage: 'Starting calculation...',
          progressValue: 0.01,
          progressStage: ProgressStage.processing,
          assignmentUrl: event.url,
        ));
        await Future.delayed(const Duration(seconds: 1));
        add(StartTaskSolving(
          tasksData: tasksData,
        ));
      } else {
        emit(state.copyWith(
          progressMessage: 'Error',
        ));
      }
    });

    on<StartTaskSolving>((event, emit) async {
      TaskSolver solver = TaskSolver();
      List<FieldModel> solvedFields = [];
      for (int i = 0; i < event.tasksData.length; i++) {
        solvedFields.add(
          await solver.solveTask(event.tasksData[i]),
        );
        emit(state.copyWith(
          progressMessage: '${i + 1} of ${event.tasksData.length} solved',
          progressValue: (i + 1) / event.tasksData.length,
        ));
      }

      emit(state.copyWith(
        progressMessage:
            'All calculations has finished, you can send your result to server',
        progressValue: 1,
        solvedTasks: solvedFields,
        progressStage: ProgressStage.result,
      ));
    });

    on<SendResultToServer>((event, emit) async {
      emit(state.copyWith(
        progressStage: ProgressStage.sending,
      ));
      List<Map<String, dynamic>> results = _parseSolvedFields();

      String? errorMessage = await webSparkClient.sendResult(
        state.assignmentUrl!,
        jsonEncode(results),
      );
      if (errorMessage == null) {
        emit(state.copyWith(
          progressStage: ProgressStage.success,
        ));
      } else {
        emit(state.copyWith(
          progressStage: ProgressStage.fail,
          errorMessage: errorMessage,
        ));
      }
    });
  }

  List<Map<String, dynamic>> _parseSolvedFields() {
    List<Map<String, dynamic>> result = [];
    List<String> paths = [];
    for (FieldModel field in state.solvedTasks!) {
      Map<String, dynamic> res = _fieldResultToMap(field);

      result.add(res['map']);
      paths.add(res['path']);
    }
    print(paths.first);
    emit(state.copyWith(
      results: paths,
    ));
    return result;
  }

  Map<String, dynamic> _fieldResultToMap(FieldModel field) {
    List<Map<String, int>> steps = [];
    String path = '';
    Map<String, dynamic> fieldData = {};
    Map<String, dynamic> res = {};

    for (int i = 0; i < field.shortestPath.length; i++) {
      FieldCellModel cell = field.shortestPath[i];
      steps.add(<String, int>{
        'x': cell.xCoordinate,
        'y': cell.yCoordinate,
      });
      path = '$path(${cell.xCoordinate},${cell.yCoordinate})';
      if (i < field.shortestPath.length - 1) {
        path = '$path->';
      }
    }
    fieldData['id'] = field.id;
    fieldData['result'] = <String, dynamic>{
      'steps': steps,
      'path': path,
    };
    res['map'] = fieldData;
    res['path'] = path;

    return res;
  }
}
