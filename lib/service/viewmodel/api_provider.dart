import 'package:interviewquestion/service/abstract/api_service.dart';
import 'package:interviewquestion/service/di/dependency_injection.dart';
import '../network_service_response.dart';

class ApiProvider {
  NetworkServiceResponse apiResult;
  APIService apiService = new Injector().flavor;

  getLanguage() async {
    NetworkServiceResponse result = await apiService.language();
    this.apiResult = result;
  }

  getQuiz() async {
    NetworkServiceResponse result = await apiService.quiz();
    this.apiResult = result;
  }

  getTopic() async {
    NetworkServiceResponse result = await apiService.topic();
    this.apiResult = result;
  }

  getInterviewQuestion() async {
    NetworkServiceResponse result = await apiService.interviewQuestion();
    this.apiResult = result;
  }
}
