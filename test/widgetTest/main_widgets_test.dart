import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flickr_android/getStarted/getStarted_Page.dart';
import 'package:flickr_android/main.dart';
import 'package:flickr_android/login/login_screen.dart';

class TesterOfWidgets {
  TesterOfWidgets(this.widget);
  Widget widget;

  void findTextOnce({String textToFind}) {
    testWidgets('find ' + textToFind, (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var expectedText = find.text(textToFind);
      expect(expectedText, findsOneWidget);
    });
  }

  void findTextField(
      {String textFieldToEnter = 'text Field', int numberOfTextField = 1}) {
    testWidgets('find ' + textFieldToEnter, (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var textField = find.byType(TextField);
      expect(textField, findsNWidgets(numberOfTextField));
      if (numberOfTextField == 1) {
        await tester.enterText(textField, textFieldToEnter);
        expect(find.text(textFieldToEnter), findsOneWidget);
      }
    });
  }

  void emailCheckingTest({String email = ''}) {
    testWidgets('test email ' + email, (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await tester.enterText(textField, email);
      expect(find.text(email), findsOneWidget);
    });
  }
}
