import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:interviewquestion/util/vars.dart';

class SplashScreen extends StatefulWidget {
  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    _navigation();

    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    animationController.forward();
    super.initState();
  }

  void _navigation() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.pushReplacementNamed(context, routeHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                new Text(appName,
                    style: new TextStyle(fontSize: 30.0, color: Colors.white),
                    textAlign: TextAlign.center),
                SizeTransition(
                    sizeFactor: new CurvedAnimation(
                        parent: animationController,
                        curve: Curves.fastOutSlowIn),
                    axis: Axis.vertical,
                    child: Container(height: 20.0)),
                CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
              ])))
    ]));
  }
}