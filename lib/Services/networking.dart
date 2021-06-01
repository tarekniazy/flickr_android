import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flickr_android/constants.dart';
import 'dart:async';
import 'dart:io';
import 'package:flickr_android/constants.dart';
import 'package:flickr_android/globals.dart' as globals;

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
      if (response.statusCode==200)
      {
        return response;

      }
      else
      {
        //    print(response.statusCode);
      }
    }


  }

  Future postData( Map<String, dynamic> Body,bool ifToken) async
  {
    if (ifToken)
      {
        var uri= Uri.parse(url);
        var response = await http.post(uri,body:Body,
        );

        return response;
      }
    else
      {
        var uri= Uri.parse(url);
        var response = await http.post(uri,body:Body, headers: {
          'Token': KUserToken,
        },);

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

}