import 'package:interviewquestion/model/interview_question_response.dart';
import 'package:interviewquestion/model/language_response.dart';
import 'package:interviewquestion/model/quiz_response.dart';
import 'package:interviewquestion/model/topic_response.dart';
import 'package:interviewquestion/service/abstract/api_service.dart';
import '../network_service_response.dart';
import '../network_type.dart';
import '../restclient.dart';

class NetworkService extends NetworkType implements APIService {
  NetworkService(RestClient rest) : super(rest);

  @override
  Future<NetworkServiceResponse<List<LanguageResponse>>> language() {
    throw UnimplementedError();
  }

  @override
  Future<NetworkServiceResponse<List<QuizResponse>>> quiz() {
    throw UnimplementedError();
  }

  @override
  Future<NetworkServiceResponse<List<TopicResponse>>> topic() {
    throw UnimplementedError();
  }

  @override
  Future<NetworkServiceResponse<List<InterviewQuestionResponse>>> interviewQuestion() {
    throw UnimplementedError();
  }

}
