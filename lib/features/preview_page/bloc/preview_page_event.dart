part of 'preview_page_bloc.dart';

@immutable
abstract class PreviewPageEvent {}

class InitialDataReception extends PreviewPageEvent {
  final FieldModel fieldModel;
  final String path;

  InitialDataReception({
    required this.fieldModel,
    required this.path,
  });
}
