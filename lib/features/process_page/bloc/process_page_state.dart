part of 'process_page_bloc.dart';

@freezed
class ProcessPageState with _$ProcessPageState {
  const factory ProcessPageState() = _ProcessPageState;

  factory ProcessPageState.success(List<FieldModel> result,List<String> paths ) = Success;

  factory ProcessPageState.processing(int numberTask,int taskDataLength) = Processing;

  factory ProcessPageState.errorState() = Error;
  factory ProcessPageState.sending() = Sending;
  factory ProcessPageState.checking() = Checking;




}
