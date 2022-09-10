part of 'preview_page_bloc.dart';

@immutable
class PreviewPageState {
  final FieldModel? fieldModel;
  final String? path;

  const PreviewPageState({
    this.fieldModel,
    this.path,
  });

  PreviewPageState copyWith({
    FieldModel? fieldModel,
    String? path,
  }) {
    return PreviewPageState(
      fieldModel: fieldModel ?? this.fieldModel,
      path: path ?? this.path,
    );
  }
}
