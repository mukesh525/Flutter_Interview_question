import 'package:interviewquestion/model/topic_response.dart';
import 'package:meta/meta.dart';

class TopicState {
  bool loading;
  final int languageId;
  final List<TopicResponse> topicList;
  String search;

  TopicState(
      {@required this.loading, this.languageId, this.topicList, this.search});

  factory TopicState.initial() {
    return TopicState(
        loading: false, languageId: 0, topicList: List(), search: null);
  }

  TopicState copyWith(
      {bool loading,
      int languageId,
      List<TopicResponse> topicList,
      String search}) {
    return TopicState(
        loading: loading ?? this.loading,
        languageId: languageId ?? this.languageId,
        topicList: topicList ?? this.topicList,
        search: search ?? this.search);
  }
}
