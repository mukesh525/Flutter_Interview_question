abstract class TopicEvent {}

class LanguageIdInput extends TopicEvent {
  final int languageId;
  LanguageIdInput({this.languageId});
}

class SearchInput extends TopicEvent {
  final String search;
  SearchInput({this.search});
}

class Topic extends TopicEvent {}
