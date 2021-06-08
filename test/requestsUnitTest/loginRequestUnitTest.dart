import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flickr_android/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mockServer.dart';

void main() {
  String url = "$KBaseUrl/user/login";

  MockClient mockClient;
  MockSource dataResource;

  setUp(() {
    mockClient = MockClient();
    dataResource = MockSource(mockClient);
  });

  group('Login: ', () {
    var uri = Uri.parse(url);

    test('login successful ', () async {
      String email = 'arwa.ibrahim.2000@gmail.com';
      String password = 'flickrflickr';
      Map<String, dynamic> body = {"email": email, "password": password};
      when(mockClient.post(uri, body: body, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '{body:{"Token":"6666666"},statusCode:"200"}', 200));
      expect(
          await dataResource.logIn(
              email: 'arwa.ibrahim.2000@gmail.com', password: 'flickrflickr'),
          200);
    });

    test('login failed: wrong email', () async {
      String email = 'arwa.ibrahim.2000@gma';
      String password = 'flickrflickreee';
      Map<String, dynamic> body = {"email": email, "password": password};

      when(mockClient.post(uri, body: body, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '{body:{"msg":"user not found"},statusCode:"404"}', 404));

      expect(
          await dataResource.logIn(
              email: 'arwa.ibrahim.2000@gma', password: 'flickrflickreee'),
          404);
    });

    test('login failed: wrong password', () async {
      String email = 'arwa.ibrahim.2000@gmail.com';
      String password = 'flickrflickreee';
      Map<String, dynamic> body = {"email": email, "password": password};

      when(mockClient.post(uri, body: body, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '{body:{"msg":"user not found"},statusCode:"401"}', 401));

      expect(
          await dataResource.logIn(
              email: 'arwa.ibrahim.2000@gmail.com',
              password: 'flickrflickreee'),
          401);
    });
  });
}
