import 'package:flutter/material.dart';
import 'package:interviewquestion/screen/page/home.dart';
import 'package:interviewquestion/screen/page/interview_question.dart';
import 'package:interviewquestion/screen/page/splashscreen.dart';
import 'package:interviewquestion/screen/page/topic.dart';
import 'package:interviewquestion/util/vars.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case routeHome:
        return MaterialPageRoute(builder: (_) => HomePage());
      case routeTopic:
        return MaterialPageRoute(
            builder: (_) => TopicPage(languageRoute: arguments));
      case routeInterViewQuestion:
        return MaterialPageRoute(
            builder: (_) => InterViewQuestionPage(topicRoute: arguments));
      default:
        return null;
    }
  }
}
