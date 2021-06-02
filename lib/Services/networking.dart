import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flickr_android/constants.dart';
import 'dart:async';
import 'dart:io';
import 'package:flickr_android/constants.dart';
import 'package:flickr_android/globals.dart' as globals;
import 'package:dio/dio.dart';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  Future getData(bool ifToken) async
  {
    if (ifToken)
    {
      var uri= Uri.parse(url);
      Map<String, String> headers = {'Token': KUserToken};
      print(headers);
      http.Response response= await http.get(uri,
          headers:headers);

      return response;

    }
    else{
      var uri= Uri.parse(url);
      http.Response response= await http.get(uri);

      return response;

    }

  }


  Future putDataDio(Map<String, dynamic> Body) async {
    var uri = Uri.parse(url);
    var dio = Dio();

    Response response = await dio.put(uri.toString(),
        data: jsonEncode(Body),
        options: Options(headers: {
          'Token': KUserToken,
        }));
    print(response.data);
    print(response.statusMessage);
    return response;
  }

  Future postData( Map<String, dynamic> Body,bool ifToken) async
  {
    print(url);

    if (ifToken)
    {
      var uri= Uri.parse(url);
      var response = await http.post(uri,body:Body, headers: {
        'Token': KUserToken,
      },);

      return response;


    }
    else
    {
      var uri= Uri.parse(url);
      var response = await http.post(uri,body:Body,
      );

      return response;

    }


    // if (response.statusCode==200)
    // {
    //   String data=response.body;
    //   return jsonDecode(data);
    //
    // }
    // else
    // {
    //   print(response.statusCode);
    // }

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

  Future deleteData() async {
    var uri = Uri.parse(url);
    var response = await http.delete(uri,
      headers:{
        'Token': KUserToken,
      }, //  HttpHeaders.authorizationHeader: KUserToken,
    );
    return response;
  }

// Future deleteData() async {
//   var uri = Uri.parse(url);
//   var dio = Dio();
//
//   Response response = await dio.delete(uri.toString(),
//       data: jsonEncode(Body),
//       options: Options(headers: {
//         'Token': KUserToken,
//       }));
//   print(response.data);
//   print(response.statusMessage);
//   return response;
// }


}