import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_task/common/constants.dart';
import 'package:test_task/data_models/field_cell_model.dart';
import 'package:test_task/data_models/field_model.dart';
import 'package:test_task/data_models/task_data.dart';
import 'package:test_task/networking/webspark_client.dart';
import 'package:test_task/utils/task_solver.dart';

part 'process_page_bloc.freezed.dart';

part 'process_page_event.dart';

part 'process_page_state.dart';

class ProcessPageBloc extends Bloc<ProcessPageEvent, ProcessPageState> {
  final WebSparkClient webSparkClient = WebSparkClient();

  ProcessPageBloc() : super(const ProcessPageState()) {
    List<FieldModel> solvedFields = [];
    List<String> paths = [];
    List<Map<String, dynamic>> results = [];
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

    List<Map<String, dynamic>> _parseSolvedFields(
        List<FieldModel> solvedTasks) {
      List<Map<String, dynamic>> result = [];
      for (FieldModel field in solvedTasks) {
        Map<String, dynamic> res = _fieldResultToMap(field);

        result.add(res['map']);
        paths.add(res['path']);
      }
      return result;
    }

    on<Initial>((event, emit) async {
      List<TaskData>? tasksData = await webSparkClient.fetchTasks(baseUrl);
      if (tasksData != null) {
        add(StartTaskSolving(
          tasksData,
        ));
      } else {
        emit(Error());
      }
    });

    on<StartTaskSolving>((event, emit) async {
      TaskSolver solver = TaskSolver();
      for (int i = 0; i < event.tasksData.length; i++) {
        solvedFields.add(
          await solver.solveTask(event.tasksData[i]),
        );
        emit(Processing(
           i + 1,
          event.tasksData.length,
        ));
        await Future.delayed(const Duration(seconds: 1));
      }
      results = _parseSolvedFields(solvedFields);

      emit(
        Sending(),
      );
    });

    on<SendResultToServer>((event, emit) async {
      emit(
        Checking(),
      );
      String? errorMessage = await webSparkClient.sendResult(
        baseUrl,
        jsonEncode(results),
      );
      if (errorMessage == null) {
        emit(Success(solvedFields, paths));
      } else {
        emit(Error());
      }
    });
  }
}
