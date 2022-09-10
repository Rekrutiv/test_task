part of 'home_page_bloc.dart';

@immutable
class HomePageState {
  final String? apiUrl;
  final bool? isUrlValid;

  const HomePageState({
    this.apiUrl,
    this.isUrlValid,
  });

  HomePageState copyWith({
    String? apiUrl,
    bool? isUrlValid
  }) {
    return HomePageState(
      apiUrl: apiUrl ?? this.apiUrl,
      isUrlValid: isUrlValid ?? this.isUrlValid,
    );
  }
}
