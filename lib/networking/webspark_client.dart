import 'package:dio/dio.dart';
import 'package:test_task/data_models/task_data.dart';

class WebSparkClient {
  final Dio _dio = Dio();

  Future<List<TaskData>?> fetchTasks(String url) async {
    try {
      Response response = await _dio.get(url);
      // [TaskData(id: 'id', field: ['...', '.X.',' .X.'], startCoordinates: {'x': 0, 'y': 0}, finishCoordinates: {'x': 0, 'y': 2})];
      List<TaskData> resultingData = [];
      for (Map<String, dynamic> jsonData in response.data['data']) {
        resultingData.add(TaskData.fromJsonData(jsonData));
      }
      return resultingData;
    } on Exception catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<String?> sendResult(String url, String json) async {
    try {
      Response response = await _dio.post(
        url,
        data: json,
      );
      if (!response.data['error']) {
        return null;
      } else {
        return response.data['message'];
      }
    } catch (exception) {
      print(exception);
      return exception.toString();
    }
  }
}
