import 'package:flutter_test/flutter_test.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flickr_android/enums.dart';

void main() {
  EnumError errorEmail;
  EnumError errorPassword;
  EnumError errorFirstName;
  EnumError errorLastName;
  EnumError errorAge;
  bool hiddenText;
  String email;
  String password;
  String firstName;
  String lastName;
  String age;
  String ageErrorText;
  String passwordErrorText;
  String emailErrorText;
  bool checkBoxValue;
  bool checkBoxRed;

  void checkBoxChecker() {
    if (checkBoxValue == false) {
      checkBoxRed = true;
    } else
      checkBoxRed = false;
  }

  group('checkBoxChecker', () {
    test('true', () {
      checkBoxValue = true;
      checkBoxChecker();
      expect(checkBoxRed, false);
    });

    test('false', () {
      checkBoxValue = false;
      checkBoxChecker();
      expect(checkBoxRed, true);
    });
  });

  void toggleHiddenText() {
    hiddenText = !hiddenText;
  }

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

  bool isPassword(String password) {
    if (password.length >= 12) {
      var str = password.trim();
      if (identical(password, str))
        return true;
      else
        return false;
    } else
      return false;
  }

  group('Is password?', () {
    bool passowrdValidity;
    test('correct format (no whitespace)', () {
      password = 'flickrflickr';
      passowrdValidity = isPassword(password);
      expect(passowrdValidity, true);
    });

    test('incorrect format (whitespace at  the end)', () {
      password = 'flickrflickr  ';
      passowrdValidity = isPassword(password);
      expect(passowrdValidity, false);
    });

    test('incorrect format (whitespace at the beginning)', () {
      password = '  flickrflickr';
      passowrdValidity = isPassword(password);
      expect(passowrdValidity, false);
    });

    test('incorrect format (short length)', () {
      password = 'flickr';
      passowrdValidity = isPassword(password);
      expect(passowrdValidity, false);
    });
  });

// Checks the String email, and performs the suitable action accordingly
  void emailChecking() {
    if (email?.isNotEmpty ?? false) {
      final bool isValid = EmailValidator.validate(email);
      if (isValid == true) {
        errorEmail = EnumError.hide;
      } else if (isValid == false) {
        errorEmail = EnumError.show;
        emailErrorText = "Invalid email";
      }
    } else if (email?.isEmpty ?? true) {
      errorEmail = EnumError.show;
      emailErrorText = "Required";
    }
  }

  group('Email checking', () {
    test('correct Format', () {
      email = 'arwa.ibrahim.2000@gmail.com';
      emailChecking();
      expect(errorEmail, EnumError.hide);
    });

    test('incorrect Format', () {
      email = 'arwa.ibrahim.2000@gmom ';
      emailChecking();
      expect(errorEmail, EnumError.show);
      expect(emailErrorText, "Invalid email");
    });

    test('empty email', () {
      email = null;
      emailChecking();
      expect(errorEmail, EnumError.show);
      expect(emailErrorText, "Required");
    });
  });

  void firstNameChecking() {
    if (firstName?.isNotEmpty ?? false) {
      errorFirstName = EnumError.hide;
    } else if (firstName?.isEmpty ?? true) {
      errorFirstName = EnumError.show;
    }
  }

  group('First name checking', () {
    test('empty', () {
      firstName = null;
      firstNameChecking();
      expect(errorFirstName, EnumError.show);
    });

    test('entered', () {
      firstName = 'Mariam';
      firstNameChecking();
      expect(errorFirstName, EnumError.hide);
    });
  });

  void lastNameChecking() {
    if (lastName?.isNotEmpty ?? false) {
      errorLastName = EnumError.hide;
    } else if (lastName?.isEmpty ?? true) {
      errorLastName = EnumError.show;
    }
  }

  group('Last name checking', () {
    test('empty', () {
      lastName = null;
      lastNameChecking();
      expect(errorLastName, EnumError.show);
    });

    test('entered', () {
      lastName = 'Mohammed';
      lastNameChecking();
      expect(errorLastName, EnumError.hide);
    });
  });

  void ageChecking() {
    if (age?.isNotEmpty ?? false) {
      final ageNumber =
          num.tryParse(age); //to check if the string can be numeric or not
      if (ageNumber == null) {
        errorAge = EnumError.show;
        ageErrorText = "Invalid age";
      } else {
        if (ageNumber < 0 || ageNumber > 120) {
          errorAge = EnumError.show;
          ageErrorText = "Invalid age";
        } else if (ageNumber >= 0 && ageNumber < 13) {
          errorAge = EnumError.show;
          ageErrorText = "In order to use Flickr, you must be 13 or older";
        } else {
          errorAge = EnumError.hide;
        }
      }
    } else if (age?.isEmpty ?? true) {
      errorAge = EnumError.show;
      ageErrorText = "Required";
    }
  }

  group('Age checking', () {
    test('not a number', () {
      age = 'Hello';
      ageChecking();
      expect(errorAge, EnumError.show);
      expect(ageErrorText, "Invalid age");
    });

    test('empty', () {
      age = null;
      ageChecking();
      expect(errorAge, EnumError.show);
      expect(ageErrorText, "Required");
    });

    test('age case less than 0', () {
      age = (-1).toString();
      ageChecking();
      expect(errorAge, EnumError.show);
      expect(ageErrorText, "Invalid age");
    });
    test('age case 0', () {
      age = 0.toString();
      ageChecking();
      expect(errorAge, EnumError.show);
      expect(ageErrorText, "In order to use Flickr, you must be 13 or older");
    });
    test('age case 13', () {
      age = 13.toString();
      ageChecking();
      expect(errorAge, EnumError.hide);
    });

    test('age case 120', () {
      age = 120.toString();
      ageChecking();
      expect(errorAge, EnumError.hide);
    });
    test('age case greater than 120', () {
      age = 121.toString();
      ageChecking();
      expect(errorAge, EnumError.show);
      expect(ageErrorText, "Invalid age");
    });
  });

  void passwordChecking() {
    if (password?.isNotEmpty ?? false) {
      if (isPassword(password))
        errorPassword = EnumError.hide;
      else {
        errorPassword = EnumError.show;
        passwordErrorText =
            "Please use at least: 12 characters and no leading spaces";
      }
    } else if (password?.isEmpty ?? true) {
      errorPassword = EnumError.show;
      passwordErrorText = "Required";
    }
  }

  group('Password checking', () {
    test('empty', () {
      password = null;
      passwordChecking();
      expect(errorPassword, EnumError.show);
    });

    test('corrrect password', () {
      password = 'flickrflickr';
      passwordChecking();
      expect(errorPassword, EnumError.hide);
    });

    test('incorrrect password', () {
      password = 'flickrr ';
      passwordChecking();
      expect(errorPassword, EnumError.show);
      expect(passwordErrorText,
          "Please use at least: 12 characters and no leading spaces");
    });
  });
}
