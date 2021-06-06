// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flickr_android/getStarted/getStarted_Page.dart' as getStarted;
import 'package:flickr_android/signup/signup_screen.dart';
import 'package:flickr_android/login/login_screen.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/src/matchers.dart';
import 'package:flutter/src/widgets/navigator.dart' hide Page;
void main() {



  testWidgets('checking On page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(getStarted.page(
      imagePath: "p1.jpg",
      title: "Powerful",
      firstLine: "Save all your photos and videos",
      secondLine: "in one place with Auto-Uploadr.",
    ),);

    await tester.pumpAndSettle(const Duration(seconds: 2));

    final titleFinder = find.text('Powerful');

    expect(titleFinder, findsOneWidget);



  });

  // testWidgets('checking Text On GetStarted', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(GetStarted());
  //
  //   final titleFinder = find.text('Powerful');
  //   final messageFinder = find.text('Get Started');
  //
  //   expect(titleFinder, findsOneWidget);
  //   expect(messageFinder, findsOneWidget);
  //
  // });
}
