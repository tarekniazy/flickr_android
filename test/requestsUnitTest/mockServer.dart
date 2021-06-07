import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flickr_android/constants.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

class MockClient extends Mock implements http.Client {}

class MockSource {
  final http.Client client;
  MockSource(this.client);

  Future<dynamic> logIn({
    String email,
    String password,
  }) async {
    var url = "$KBaseUrl/user/login";
    Map<String, dynamic> body = {"email": email, "password": password};
    var result = await client.post(Uri.parse(url), body: body);

    if (result.statusCode != null) {
      return (result.statusCode);
    } else {
      throw (json.decode(result.body)['message']);
    }
  }

  Future<dynamic> signup({
    String email,
    String password,
    String firstName,
    String lastName,
    String age,
  }) async {
    var url = "$KBaseUrl/user";
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "age": age
    };
    var result = await client.put(Uri.parse(url), body: body);

    if (result.statusCode != null) {
      return (result.statusCode);
    } else {
      throw (json.decode(result.body)['message']);
    }
  }
}
