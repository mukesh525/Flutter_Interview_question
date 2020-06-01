import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'vars.dart';

extension ContextExtensions on BuildContext {
  showProgress(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorProgressBar)),
            ));
  }

  void hideProgress(BuildContext context) {
    Navigator.pop(context);
  }
}

extension WidgetExtensions on Widget {
  cardView(EdgeInsets margin, EdgeInsets padding) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0, // has the effect of softening the shadow
                spreadRadius: 0.5, // has the effect of extending the shadow
                offset: Offset(
                    0, // horizontal, move right 10
                    0 // vertical, move down 10
                    ))
          ]),
      child: this,
      margin: margin,
      padding: padding);

  marginVisible({EdgeInsets edgeInsets, bool isVisible = true}) => Visibility(
      visible: isVisible,
      child: Container(
          margin: (edgeInsets == null) ? EdgeInsets.all(0) : edgeInsets,
          child: this));

  circleAvatar({double radius, Color color}) =>
      CircleAvatar(radius: radius, backgroundColor: color, child: this);

  roundCircleButton(
          IconData iconData, bool isMini, VoidCallback voidCallback) =>
      FloatingActionButton(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          mini: isMini,
          onPressed: voidCallback,
          child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientsButton)),
              child: Stack(fit: StackFit.expand, children: <Widget>[
                Icon(iconData, size: 30, color: Colors.black)
              ])));

  customFloatForm(
          {IconData icon, VoidCallback qrCallback, bool isMini = false}) =>
      FloatingActionButton(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          mini: isMini,
          onPressed: qrCallback,
          child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientsButton)),
              child: Stack(fit: StackFit.expand, children: <Widget>[
                Icon(icon, size: 30, color: Colors.blue)
              ])));

  expandStyle(int flex, Widget child) => Expanded(flex: flex, child: child);
}
