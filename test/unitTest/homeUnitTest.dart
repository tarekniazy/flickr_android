import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Color bottonClicked(var button) {
    if (button == 1) {
      return Colors.white;
    } else {
      return Colors.white38;
    }
  }

  group('botton clicked', () {
    test('case one, white', () {
      Color bottonColor = bottonClicked(1);
      expect(bottonColor, Colors.white);
    });

    test('case any int, white shade', () {
      Color bottonColor = bottonClicked(4);
      expect(bottonColor, Colors.white38);
    });
  });
}
