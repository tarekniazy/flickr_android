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
