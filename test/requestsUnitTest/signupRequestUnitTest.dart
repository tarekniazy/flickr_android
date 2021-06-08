import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flickr_android/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'mockServer.dart';

void main() {
  String url = "$KBaseUrl/user";

  MockClient mockClient;
  MockSource dataResource;

  setUp(() {
    mockClient = MockClient();
    dataResource = MockSource(mockClient);
  });

  group('Sign up: ', () {
    var uri = Uri.parse(url);

    test(' successful ', () async {
      String email = 'arwa.ibrahim.2000@gmail.com';
      String password = 'flickrflickr';
      String firstName = 'Mariam';
      String lastName = 'Mohamed';
      String age = '21';
      Map<String, dynamic> body = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "age": age
      };

      when(mockClient.put(uri, body: body, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('{statusCode:"201"}', 201));
      expect(
          await dataResource.signup(
              email: 'arwa.ibrahim.2000@gmail.com',
              password: 'flickrflickr',
              firstName: 'Mariam',
              lastName: 'Mohamed',
              age: '21'),
          201);
    });

    test('signup failed: user exists ', () async {
      String email = 'arwa.ibrahim.2000@gmail.com';
      String password = 'flickrflickr';
      String firstName = 'Mariam';
      String lastName = 'Mohamed';
      String age = '21';
      Map<String, dynamic> body = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "age": age
      };

      when(mockClient.put(uri, body: body, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '{body:{"msg":"Email unavailable"},statusCode:"422"}', 422));
      expect(
          await dataResource.signup(
              email: 'arwa.ibrahim.2000@gmail.com',
              password: 'flickrflickr',
              firstName: 'Mariam',
              lastName: 'Mohamed',
              age: '21'),
          422);
    });

    test('signup failed: server error ', () async {
      String email = 'arwa.ibrahim.2000@gmail.com';
      String password = 'flickrflickr';
      String firstName = 'Mariam';
      String lastName = 'Mohamed';
      String age = '21';
      Map<String, dynamic> body = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "age": age
      };

      when(mockClient.put(uri, body: body, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '{body:{"msg":"Failed to create user"},statusCode:"422"}', 422));
      expect(
          await dataResource.signup(
              email: 'arwa.ibrahim.2000@gmail.com',
              password: 'flickrflickr',
              firstName: 'Mariam',
              lastName: 'Mohamed',
              age: '21'),
          422);
    });
  });
}
