import 'package:interviewquestion/model/interview_question_response.dart';
import 'package:interviewquestion/model/language_response.dart';
import 'package:interviewquestion/model/quiz_response.dart';
import 'package:interviewquestion/model/topic_response.dart';

import '../network_service_response.dart';

abstract class APIService {
  Future<NetworkServiceResponse<List<QuizResponse>>> quiz();
  Future<NetworkServiceResponse<List<LanguageResponse>>> language();
  Future<NetworkServiceResponse<List<TopicResponse>>> topic();
  Future<NetworkServiceResponse<List<InterviewQuestionResponse>>> interviewQuestion();
}
