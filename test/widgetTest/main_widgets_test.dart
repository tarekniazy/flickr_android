import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flickr_android/getStarted/getStarted_Page.dart' as getStarted;

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

  void getUserCards({List<dynamic> userCards}) {
    testWidgets('testing user Cards ', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var expectedText = find.byType(Container);
      expect(expectedText, findsNWidgets(2));
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
