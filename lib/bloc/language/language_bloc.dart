import 'package:bloc/bloc.dart';
import 'package:interviewquestion/service/viewmodel/api_provider.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final ApiProvider apiProvider = ApiProvider();

  void language() {
    add(Language());
  }

  void quiz() {
    add(Quiz());
  }

  @override
  LanguageState get initialState => LanguageState.initial();

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is Language) {
      yield state.copyWith(loading: true);
      await apiProvider.getLanguage();

      try {
        var response = apiProvider.apiResult.response;
        yield state.copyWith(loading: false, languageList: response);
      } catch (e) {
        yield state.copyWith(loading: false);
      }
    }

    if (event is Quiz) {
      yield state.copyWith(loading: true);
      await apiProvider.getQuiz();

      try {
        var response = apiProvider.apiResult.response;
        yield state.copyWith(loading: false, quizList: response);
      } catch (e) {
        yield state.copyWith(loading: false);
      }
    }
  }
}
