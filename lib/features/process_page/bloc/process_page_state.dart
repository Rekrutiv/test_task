part of 'process_page_bloc.dart';

@immutable
class ProcessPageState {
  final String progressMessage;
  final double progressValue;
  final List<FieldModel>? solvedTasks;
  final ProgressStage progressStage;
  final  List<String>? results;


  const ProcessPageState({
    this.progressMessage = 'Fetching data...',
    this.progressValue = 0,
    this.solvedTasks,
    this.progressStage = ProgressStage.fetching,
    this.results,
  });

  ProcessPageState copyWith({
    String? progressMessage,
    double? progressValue,
    String? assignmentUrl,
    List<FieldModel>? solvedTasks,
    String? errorMessage,
    ProgressStage? progressStage,
    List<String>? results
  }) {
    return ProcessPageState(
      progressMessage: progressMessage ?? this.progressMessage,
      progressValue: progressValue ?? this.progressValue,
      solvedTasks: solvedTasks ?? this.solvedTasks,
      progressStage: progressStage ?? this.progressStage,
        results:results??this.results
    );
  }
}

enum ProgressStage {
  fetching,
  processing,
  result,
  sending,
  fail,
  success,
}
