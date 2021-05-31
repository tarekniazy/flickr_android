import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flickr_android/constants.dart';

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
        if (response.statusCode==200)
        {
          return response;

        }
        else
        {
             print(response.statusCode);
        }
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
          'token': KUserToken,
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

}