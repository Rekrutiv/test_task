import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task/common/constants.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(const HomePageState()) {
    on<UrlSubmitted>((event, emit) {
      String submittedUrl = event.url.trim();
      if (submittedUrl.startsWith(baseUrl)) {
        emit(state.copyWith(
          apiUrl: submittedUrl,
          isUrlValid: true,
        ));
      } else {
        emit(state.copyWith(
          isUrlValid: false,
        ));
      }
    });
  }
}
