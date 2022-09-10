part of 'process_page_bloc.dart';

@immutable
abstract class ProcessPageEvent {}

class FetchInitialData extends ProcessPageEvent {
  final String url;

  FetchInitialData({required this.url});
}

class StartTaskSolving extends ProcessPageEvent {
  final List<TaskData> tasksData;

  StartTaskSolving({required this.tasksData});
}

class SendResultToServer extends ProcessPageEvent {}
