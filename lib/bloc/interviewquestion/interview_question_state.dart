import 'package:interviewquestion/model/interview_question_response.dart';
import 'package:meta/meta.dart';

class InterviewQuestionState {
  bool loading;
  final int languageId, topicId;
  final List<InterviewQuestionResponse> interviewQuestionList;
  String search;

  InterviewQuestionState(
      {@required this.loading,
      this.languageId,
      this.topicId,
      this.interviewQuestionList,
      this.search});

  factory InterviewQuestionState.initial() {
    return InterviewQuestionState(
        loading: false,
        languageId: 0,
        topicId: 0,
        interviewQuestionList: List(),
        search: null);
  }

  InterviewQuestionState copyWith(
      {bool loading,
      int languageId,
      int topicId,
      List<InterviewQuestionResponse> interviewQuestionList,
      String search}) {
    return InterviewQuestionState(
        loading: loading ?? this.loading,
        languageId: languageId ?? this.languageId,
        topicId: topicId ?? this.topicId,
        interviewQuestionList:
            interviewQuestionList ?? this.interviewQuestionList,
        search: search ?? this.search);
  }
}
