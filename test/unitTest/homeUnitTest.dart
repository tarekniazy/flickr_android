import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flickr_android/home/home.dart';
import 'package:flickr_android/Services/networking.dart';
import 'package:flickr_android/constants.dart';
import 'dart:convert';

void main() {
  List<dynamic> response;
  var res;

  void getExploreData() async {
    NetworkHelper req2 = new NetworkHelper("$KBaseUrl/photo/explore");
    res = await req2.getData(true);
    print(res.statusCode);
    if (res.statusCode == 200) {
      String data = res.body;
      response = jsonDecode(data);
      print(response);
    } else {
      print(res.statusCode);
    }
  }

  // group('Get explore data', () {
  //   test('No token', () async {
  //     await getExploreData();
  //     expect(res.statusCode, 403);
  //   });
  // });

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
