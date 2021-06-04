import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flickr_android/login/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flickr_android/enums.dart';

void main() {
  EnumError errorEmail = EnumError.hide;
  EnumError errorPassword = EnumError.hide;
  bool visibility;
  bool hiddenText;
  bool popUpMsg;
  String buttonText = 'Next';
  String email;

  void changeButtonTextToSignIn() {
    buttonText = 'Sign in';
  }

  void toggleHiddenText() {
    hiddenText = !hiddenText;
  }

  void isMail(EnumEmail mail) {
    if (mail == EnumEmail.valid) {
      errorEmail = EnumError.hide;
    } else {
      errorEmail = EnumError.show;
    }
  }

  // Checks the String email, and performs the suitable action accordingly
  void emailChecking() {
    if (email?.isNotEmpty ?? false) {
      final bool isValid = EmailValidator.validate(email);
      isValid ? isMail(EnumEmail.valid) : isMail(EnumEmail.invalid);
      if (isValid == true) {
        visibility = true;
      }
    } else if (email?.isEmpty ?? true) {
      errorEmail = EnumError.show;
    } else {
      popUpMsg = true;
    }
  }

  test('Change text to sign in', () {
    changeButtonTextToSignIn();
    expect(buttonText, 'Sign in');
  });

  group('toggling hidden text', () {
    test('value from true to false', () {
      hiddenText = true;
      toggleHiddenText();
      expect(hiddenText, false);
    });

    test('value from false to true', () {
      hiddenText = false;
      toggleHiddenText();
      expect(hiddenText, true);
    });
  });

  group('isMail', () {
    test('Valid', () {
      EnumEmail mail = EnumEmail.valid;
      isMail(mail);
      expect(errorEmail, EnumError.hide);
    });

    test('Invalid', () {
      EnumEmail mail = EnumEmail.invalid;
      isMail(mail);
      expect(errorEmail, EnumError.show);
    });
  });

  group('email format Checking', () {
    test('Correct Format', () {
      email = 'arwa.ibrahim.2000@gmail.com';
      emailChecking();
      expect(visibility, true);
    });

    // test('Incorrect Format', () {
    //   email = 'arwa.ibrahim.200';
    //   emailChecking();
    //   expect(popUpMsg, true);
    // });

    test('empty email', () {
      email = null;
      emailChecking();
      expect(errorEmail, EnumError.show);
    });
  });
}

// test('Counter increments smoke test', () async {
// // Build our app and trigger a frame.
// await tester.pumpWidget(GetStarted());
//
// // Verify that our counter starts at 0.
// expect(find.text('0'), findsOneWidget);
// expect(find.text('1'), findsNothing);
//
// // Tap the '+' icon and trigger a frame.
// await tester.tap(find.byIcon(Icons.add));
// await tester.pump();
//
// // Verify that our counter has incremented.
// expect(find.text('0'), findsNothing);
// expect(find.text('1'), findsOneWidget);
// });