import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  Future getData() async
  {
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

  Future postData( Map<String, dynamic> Body) async
  {
    var uri= Uri.parse(url);
    var response = await http.post(uri,body:Body);

    return response;

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