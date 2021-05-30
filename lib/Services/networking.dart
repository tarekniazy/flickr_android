import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flickr_android/constants.dart';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  Future getData() async {
    var uri = Uri.parse(url);
    Map<String, String> headers = {'Token': KUserToken};
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response;
    }
  }

  Future postData(Map<String, dynamic> Body) async {
    var uri = Uri.parse(url);
    var response = await http.post(uri, body: Body);

    return response;
  }

  Future putData(Map<String, String> Body) async {
    var uri = Uri.parse(url);
    Map<String, String> headers = {'Token': KUserToken};
    var response = await http.put(uri,
        body: Body,
        headers: headers //  HttpHeaders.authorizationHeader: KUserToken,
        );
    print(Body);
    return response;
  }
}
