import 'package:interviewquestion/model/language_response.dart';
import 'package:interviewquestion/model/quiz_response.dart';

class LanguageState {
  final List<LanguageResponse> languageList;
  final List<QuizResponse> quizList;
  bool loading;

  LanguageState({this.loading, this.languageList, this.quizList});

  factory LanguageState.initial() {
    return LanguageState(
        loading: false, languageList: List(), quizList: List());
  }

  LanguageState copyWith(
      {bool loading,
      List<LanguageResponse> languageList,
      List<QuizResponse> quizList}) {
    return LanguageState(
        loading: loading ?? this.loading,
        languageList: languageList ?? this.languageList,
        quizList: quizList ?? this.quizList);
  }
}
