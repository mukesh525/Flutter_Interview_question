import 'package:bloc/bloc.dart';
import 'package:interviewquestion/model/topic_response.dart';
import 'package:interviewquestion/service/viewmodel/api_provider.dart';
import 'package:interviewquestion/util/vars.dart';
import 'topic_event.dart';
import 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final ApiProvider apiProvider = ApiProvider();
  var searchList;

  void languageIdInput(languageId) {
    add(LanguageIdInput(languageId: languageId));
  }

  void topic() {
    add(Topic());
  }

  void searchInput(search) {
    add(SearchInput(search: search));
  }

  @override
  TopicState get initialState => TopicState.initial();

  @override
  Stream<TopicState> mapEventToState(TopicEvent event) async* {
    if (event is LanguageIdInput) {
      yield state.copyWith(languageId: event.languageId);
    }

    if (event is SearchInput) {
      yield state.copyWith(search: event.search);

      if (event.search.isEmpty) {
        yield state.copyWith(loading: false, topicList: searchList);
      } else {
        List<TopicResponse> _searchList = [];
        searchList.forEach((p) {
          if (p.topic.toLowerCase().contains(state.search.toLowerCase())) {
            _searchList.add(p);
          }
        });

        yield state.copyWith(loading: false, topicList: _searchList);
      }
    }

    if (event is Topic) {
      yield state.copyWith(loading: true);
      await apiProvider.getTopic();

      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          List<TopicResponse> response = apiProvider.apiResult.response;
          searchList = response
              .where((topic) => topic.subjectId == state.languageId)
              .toList();

          yield state.copyWith(loading: false, topicList: searchList);
        }
      } catch (e) {
        yield state.copyWith(loading: false);
      }
    }
  }
}
