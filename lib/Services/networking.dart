import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flickr_android/constants.dart';
import 'package:flickr_android/globals.dart' as globals;

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  Future getData() async {
    var uri = Uri.parse(url);
    Map<String, String> headers = {'Token': globals.userToken};
    http.Response response = await http.get(uri, headers: headers);
    print(response.statusCode);
    print(globals.userToken);
    if (response.statusCode == 200) {
      return response;
    }
  }

  Future postData(Map<String, dynamic> body) async {
    var uri = Uri.parse(url);
    Map<String, String> headers = {'Token': globals.userToken};
    var response = await http.post(uri, body: body, headers: headers);

    return response;
  }

  Future putData(Map<String, dynamic> body) async {
    var uri = Uri.parse(url);

    var encoded = utf8.encode('Lorem ipsum dolor sit amet, consetetur...');
    String json = jsonEncode(body);
    // print(json);
    Map<String, String> headers = {'Token': globals.userToken};
    var response = await http.put(uri,
        body: json,
        headers: headers //  HttpHeaders.authorizationHeader: KUserToken,
        );

    return response;
  }

  Future putDataString(String body) async {
    var uri = Uri.parse(url);
    Map<String, String> headers = {'Token': globals.userToken};
    var response = await http.put(uri,
        body: json.decode(body),
        headers: headers //  HttpHeaders.authorizationHeader: KUserToken,
        );
    return response;
  }
}
