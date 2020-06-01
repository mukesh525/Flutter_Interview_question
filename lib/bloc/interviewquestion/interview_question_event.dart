abstract class InterviewQuestionEvent {}

class LanguageIdInput extends InterviewQuestionEvent {
  final int languageId;
  LanguageIdInput({this.languageId});
}

class SearchInput extends InterviewQuestionEvent {
  final String search;
  SearchInput({this.search});
}

class TopicIdInput extends InterviewQuestionEvent {
  final int topicId;
  TopicIdInput({this.topicId});
}

class InterviewQuestion extends InterviewQuestionEvent {}
