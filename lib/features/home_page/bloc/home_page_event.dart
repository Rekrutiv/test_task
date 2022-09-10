part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class UrlSubmitted extends HomePageEvent {
  final String url;

  UrlSubmitted({
    required this.url,
  });
}
