import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'package:flickr_android/Services/networking.dart';
import 'dart:convert';

class AboutSubscreen extends StatefulWidget {
  AboutSubscreen(this.subScreenMainText, this.subScreenSubText);
  final subScreenMainText;
  final subScreenSubText;
  @override
  _AboutSubscreenState createState() =>
      _AboutSubscreenState(subScreenMainText, subScreenSubText);
}

class _AboutSubscreenState extends State<AboutSubscreen> {
  _AboutSubscreenState(this.subScreenMainText, this.subScreenSubText);
  final subScreenMainText;
  final subScreenSubText;
  bool buttonBoolean = false;
  String buttonText = 'Next';
  String givenUserData;
  String userToken;

  @override
  void initState() {
    super.initState();
    getOriginalAbout();
  }

  void getOriginalAbout() async {
    NetworkHelper req = new NetworkHelper("$KBaseUrl/user/about");
    var res = await req.getData();
    if (res.statusCode == 200) {
      print('get Success');
      print(res.body);
    } else {
      print('weeee');

      print(res.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey[800],
            title: Text(widget.subScreenMainText),
            actions: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3.0)),
                  child: TextButton(
                      onPressed: () async {
                        if (buttonText == 'Done') {
                          // Map<String, String> body;
                          // body = {subScreenMainText: givenUserData};
                          // Map<String, Map<String, dynamic>> theSnapShot;
                          // theSnapShot = {'About': body};
                          //
                          // Map<String, String> stringQueryParameters =
                          //     theSnapShot.map((key, value) =>
                          //         MapEntry(key, value?.toString()));
                          //
                          // print(stringQueryParameters);
                          // print(body.runtimeType);
                          var stringQueryParameters =
                              " {About: {Description: Yarbffg}}";
                          NetworkHelper req =
                              new NetworkHelper("$KBaseUrl/user");
                          var res =
                              await req.putDataString(stringQueryParameters);
                          if (res.statusCode == 200) {
                            print('Success');
                          } else {
                            print(res.statusCode);
                            print(res.body);
                          }
                        }
                        ;
                      },
                      child: Text(
                        buttonText,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ), // Edit and Done Button
            ]),
        body: TextField(
          maxLines: null,
          onTap: () {
            setState(() {
              buttonText = 'Done';
              //TODO Arwa- Modify to do a functionality in the Next phase
            });
          },
          onChanged: (value) {
            givenUserData = value;
          },
          decoration: InputDecoration(
            isDense: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "   " + widget.subScreenSubText + "...",
          ),
        ),
      ),
    );
  }
}
