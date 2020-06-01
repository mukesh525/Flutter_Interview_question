import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewquestion/bloc/language/language_bloc.dart';
import 'bloc/interviewquestion/interview_question_bloc.dart';
import 'bloc/topic/topic_bloc.dart';
import 'service/di/dependency_injection.dart';
import 'util/route.dart';
import 'util/vars.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.blue,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.blue,
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(dark);

  Injector.configure(Flavor.Testing);
  //runApp(MyApp());

  runApp(MultiBlocProvider(providers: [
    BlocProvider<LanguageBloc>(
      create: (BuildContext context) => LanguageBloc(),
    ),
    BlocProvider<TopicBloc>(
      create: (BuildContext context) => TopicBloc(),
    ),
    BlocProvider<InterviewQuestionBloc>(
      create: (BuildContext context) => InterviewQuestionBloc(),
    )
  ], child: new MyApp()));
}

class MyApp extends StatelessWidget {
  final materialApp = MaterialApp(
      title: appName,
      theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.blue,
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
          fontFamily: quickFont),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute);

  @override
  Widget build(BuildContext context) {
    return  materialApp;
  }
}
