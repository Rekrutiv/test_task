part of 'process_page_bloc.dart';


@freezed
class ProcessPageEvent with _$ProcessPageEvent {
  const factory ProcessPageEvent.initial() = Initial;

  const factory ProcessPageEvent.startTaskSolving(
      List<TaskData> tasksData) = StartTaskSolving;

  const factory ProcessPageEvent.sendResultToServer() = SendResultToServer;

}

