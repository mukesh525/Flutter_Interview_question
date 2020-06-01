import 'dart:async';
import 'package:interviewquestion/model/interview_question_response.dart';
import 'package:interviewquestion/model/language_response.dart';
import 'package:interviewquestion/model/quiz_response.dart';
import 'package:interviewquestion/model/topic_response.dart';
import 'package:interviewquestion/service/abstract/api_service.dart';
import 'package:interviewquestion/util/vars.dart';
import '../network_service_response.dart';
import 'api_view_model.dart';

class MockService implements APIService {
  @override
  Future<NetworkServiceResponse<List<LanguageResponse>>> language() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(
        NetworkServiceResponse(responseCode: ok200, response: getLanguage()));
  }

  @override
  Future<NetworkServiceResponse<List<QuizResponse>>> quiz() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(
        NetworkServiceResponse(responseCode: ok200, response: getQuiz()));
  }

  @override
  Future<NetworkServiceResponse<List<TopicResponse>>> topic() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200, response: getTopic(), errorMessage: null));
  }

  @override
  Future<NetworkServiceResponse<List<InterviewQuestionResponse>>>
      interviewQuestion() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200,
        response: getInterviewQuestion(),
        errorMessage: null));
  }
}
