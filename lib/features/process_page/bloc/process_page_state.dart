part of 'process_page_bloc.dart';

@immutable
class ProcessPageState {
  final String progressMessage;
  final double progressValue;
  final String? assignmentUrl;
  final List<FieldModel>? solvedTasks;
  final String? errorMessage;
  final ProgressStage progressStage;
  final  List<String>? results;


  const ProcessPageState({
    this.progressMessage = 'Fetching data...',
    this.progressValue = 0,
    this.assignmentUrl,
    this.solvedTasks,
    this.errorMessage,
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
      assignmentUrl: assignmentUrl ?? this.assignmentUrl,
      solvedTasks: solvedTasks ?? this.solvedTasks,
      errorMessage: errorMessage ?? this.errorMessage,
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
