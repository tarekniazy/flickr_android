// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import '../main_widgets_test.dart';
import 'package:flickr_android/signup/signup_screen.dart';

void main() {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(), child: new MaterialApp(home: SignUpScreen()));

  TesterOfWidgets testerOfWidgets = TesterOfWidgets(testWidget);
  testerOfWidgets.findTextOnce(textToFind: 'Sign Up for Flickr');
  testerOfWidgets.findTextOnce(textToFind: 'flickr');
  testerOfWidgets.findTextOnce(textToFind: 'Already a Flickr member?');
  testerOfWidgets.findTextButton(numberOfTextButton: 2);
  testerOfWidgets.findTextField(
      textFieldToEnter: 'Entered Text', numberOfTextField: 5);
}
