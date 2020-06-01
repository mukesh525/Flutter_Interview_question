import 'package:bloc/bloc.dart';
import 'package:interviewquestion/model/interview_question_response.dart';
import 'package:interviewquestion/service/viewmodel/api_provider.dart';
import 'package:interviewquestion/util/vars.dart';
import 'interview_question_event.dart';
import 'interview_question_state.dart';

class InterviewQuestionBloc
    extends Bloc<InterviewQuestionEvent, InterviewQuestionState> {
  final ApiProvider apiProvider = ApiProvider();
  List<InterviewQuestionResponse> searchList;

  void languageIdInput(languageId) {
    add(LanguageIdInput(languageId: languageId));
  }

  void topicIdInput(topicId) {
    add(TopicIdInput(topicId: topicId));
  }

  void interviewQuestion() {
    add(InterviewQuestion());
  }

  void searchInput(search) {
    add(SearchInput(search: search));
  }

  @override
  InterviewQuestionState get initialState => InterviewQuestionState.initial();

  @override
  Stream<InterviewQuestionState> mapEventToState(
      InterviewQuestionEvent event) async* {
    if (event is LanguageIdInput) {
      yield state.copyWith(languageId: event.languageId);
    }

    if (event is TopicIdInput) {
      yield state.copyWith(topicId: event.topicId);
    }

    if (event is SearchInput) {
      yield state.copyWith(search: event.search);

      if (event.search.isEmpty) {
        yield state.copyWith(loading: false, interviewQuestionList: searchList);
      } else {
        List<InterviewQuestionResponse> _searchList = [];
        searchList.forEach((p) {
          if (p.question.toLowerCase().contains(state.search.toLowerCase()) ||
              p.answer.toLowerCase().contains(state.search.toLowerCase())) {
            _searchList.add(p);
          }
        });

        yield state.copyWith(
            loading: false, interviewQuestionList: _searchList);
      }
    }

    if (event is InterviewQuestion) {
      yield state.copyWith(loading: true);
      await apiProvider.getInterviewQuestion();

      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          List<InterviewQuestionResponse> response =
              apiProvider.apiResult.response;

          searchList = response
              .where((interviewQuestion) =>
                  interviewQuestion.subjectId == state.languageId &&
                  interviewQuestion.topicId == state.topicId)
              .toList();

          yield state.copyWith(
              loading: false, interviewQuestionList: searchList);
        }
      } catch (e) {
        yield state.copyWith(loading: false);
      }
    }
  }
}
