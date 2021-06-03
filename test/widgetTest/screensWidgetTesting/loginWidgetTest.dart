// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flickr_android/login/login_screen.dart';
import '../main_widgets_test.dart';

void main() {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: LoggingInScreen()));

  TesterOfWidgets testerOfWidgets = TesterOfWidgets(testWidget);
  testerOfWidgets.findTextOnce(textToFind: 'Log in to Flickr');
  testerOfWidgets.findTextOnce(textToFind: 'flickr');
  testerOfWidgets.findTextOnce(textToFind: 'Not a Flickr member?');
  testerOfWidgets.findTextField(textFieldToEnter: 'Entered Text');
}
