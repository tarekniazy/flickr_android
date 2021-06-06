import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // const Icon iconFav = Icon(
  //   Icons.star,
  //   color: Colors.blue,
  // );
  int isfaved;
  String text;
  String LastComment;
  String LastUser;
  final List<dynamic> comments = [];
  var like;

  String ifLastComment() {
    if (comments.length != 0) {
      LastUser = comments.last["user"]["Fname"];
      return comments.last["comment"];
    } else {
      LastUser = " ";
      return " ";
    }
  }

  group('If last comment', () {
    test('case !empty list', () {
      comments.add({
        "comment": 'hi',
        "user": {
          "Fname": 'Arwa',
        },
      });
      comments.add({
        "comment": 'hello',
        "user": {
          "Fname": 'Mariam',
        },
      });
      comments.add({
        "comment": 'hey',
        "user": {
          "Fname": 'Tarek',
        },
      });
      String comment = ifLastComment();
      expect(comment, 'hey');
    });
    test('case empty list', () {
      comments.clear();
      String comment = ifLastComment();
      expect(comment, ' ');
    });
  });

  String ifLastUserComment() {
    if (comments.length != 0) {
      return comments.last["user"]["Fname"];
    } else {
      return " ";
    }
  }

  group('If last user comment', () {
    test('case !empty list', () {
      comments.add({
        "comment": 'hi',
        "user": {
          "Fname": 'Arwa',
        },
      });
      comments.add({
        "comment": 'hello',
        "user": {
          "Fname": 'Mariam',
        },
      });
      comments.add({
        "comment": 'hey',
        "user": {
          "Fname": 'Tarek',
        },
      });
      String comment = ifLastUserComment();
      expect(comment, 'Tarek');
    });
    test('case empty list', () {
      comments.clear();
      String comment = ifLastUserComment();
      expect(comment, ' ');
    });
  });

  Text checkIfAvailble(int number) {
    if (number > 0) {
      text = '$number';
      return Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Frutiger',
          color: Colors.black54,
        ),
      );
    } else if (number == 0 || number == null) {
      text = ' ';
      return Text(
        text,
      );
    }
  }

  group('Check if available', () {
    test('case one like', () {
      Text bottonColor = checkIfAvailble(1);
      expect(text, '1');
    });
    test('case no like', () {
      Text bottonColor = checkIfAvailble(0);
      expect(text, ' ');
    });
  });

  Icon likePressed() {
    if (isfaved == 1) {
      return Icon(
        Icons.star,
        color: Colors.blue,
      );
    } else {
      return Icon(
        Icons.star_border,
      );
    }
  }

  // group('Like pressed', () {
  //   test('favorited', () {
  //     isfaved = 1;
  //     Icon likePress = likePressed();
  //     expect(likePress, iconFav);
  //   });
  //   test('unliked', () {
  //     isfaved = 0;
  //     Icon likePress = likePressed();
  //     expect(
  //         likePress,
  //         Icon(
  //           Icons.star_border,
  //         ));
  //   });
  // });
}
