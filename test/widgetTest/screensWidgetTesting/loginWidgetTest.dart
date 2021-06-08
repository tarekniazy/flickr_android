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
  testerOfWidgets.findTextButton(numberOfTextButton: 2);
  testerOfWidgets.emailCheckingTest(
      email: 'arwa.ibrahim.2000@gmail.com', buttonText: 'Next');
}
