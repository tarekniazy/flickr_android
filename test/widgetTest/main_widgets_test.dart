import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flickr_android/getStarted/getStarted_Page.dart' as getStarted;
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:flickr_android/constants.dart';
import 'dart:convert';
import 'package:flickr_android/login/login_screen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

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

  void findTextButton({int numberOfTextButton = 1}) {
    testWidgets('find button', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var textButton = find.byType(TextButton);
      expect(textButton, findsNWidgets(numberOfTextButton));
    });
  }

  void findElevatedButton({int numberOfElevatedButton = 1}) {
    testWidgets('find elevated button', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var elevatedButton = find.byType(ElevatedButton);
      expect(elevatedButton, findsNWidgets(numberOfElevatedButton));
    });
  }

  void findAvatar({int numberAvatar = 1}) {
    testWidgets('find avatar', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var avatar = find.byType(CircleAvatar);
      expect(avatar, findsNWidgets(numberAvatar));
    });
  }

  void findPage({int numberOfPage = 1}) {
    testWidgets('find page', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var page = find.byType(getStarted.page);
      expect(page, findsNWidgets(numberOfPage));
    });
  }

  void findIconButton({int numberOfIconButton = 1}) {
    testWidgets('find icon button', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var iconButton = find.byType(IconButton);
      expect(iconButton, findsNWidgets(numberOfIconButton));
      //
      // var client = MockClient((request) async {
      //   if (request.url.path != "/data.json") {
      //     return http.Response("", 404);
      //   }
      //   return http.Response(
      //       json.encode({
      //         'numbers': [1, 4, 15, 19, 214]
      //       }),
      //       200,
      //       headers: {'content-type': 'application/json'});
      // });
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

  void getStartedLogIn() {
    testWidgets('testing ', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      navigatorObservers:
      [mockObserver];
      await tester.pumpWidget(widget);
      var button = find.text('Get Started');
      await tester.tap(button);
      await tester.pumpAndSettle();
      verifyNever(mockObserver.didPush(any, any));
    });
  }

  void emailCheckingTest({String email, String buttonText}) {
    testWidgets('test email ' + email, (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      navigatorObservers:
      [mockObserver];
      await tester.pumpWidget(widget);
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await tester.enterText(textField, email);
      expect(find.text(email), findsOneWidget);
      var button = find.text(buttonText);
      await tester.tap(button);
      await tester.pumpAndSettle();
      verifyNever(mockObserver.didPush(any, any));
      textField = find.byType(TextField);
      expect(textField, findsNWidgets(2));
    });
  }
}
