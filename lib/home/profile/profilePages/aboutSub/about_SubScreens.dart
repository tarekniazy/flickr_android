import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'package:flickr_android/Services/networking.dart';
import 'package:flickr_android/home/customeWidgets.dart';

class AboutSubscreen extends StatefulWidget {
  AboutSubscreen(this.subScreenMainText, this.subScreenSubText,
      this.isSubScreenSubTextEmpty);
  final subScreenMainText;
  final subScreenSubText;
  final isSubScreenSubTextEmpty;
  @override
  _AboutSubscreenState createState() => _AboutSubscreenState(
      subScreenMainText, subScreenSubText, isSubScreenSubTextEmpty);
}

class _AboutSubscreenState extends State<AboutSubscreen> {
  _AboutSubscreenState(this.subScreenMainText, this.subScreenSubText,
      this.isSubScreenSubTextEmpty);
  final subScreenMainText;
  final subScreenSubText;
  final isSubScreenSubTextEmpty;
  bool buttonBoolean = false;
  String buttonText = 'Edit';
  String givenUserData;
  String userToken;

  @override
  void initState() {
    super.initState();
    // getOriginalAbout();
  }

  // void getOriginalAbout() async {
  //   NetworkHelper req = new NetworkHelper("$KBaseUrl/user/about");
  //   var res = await req.getData(true);
  //   if (res.statusCode == 200) {
  //     print('get Success');
  //     print(res.body);
  //   } else {
  //     print('weeee');
  //
  //     print(res.statusCode);
  //   }
  // }

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
                          Map<String, String> body = {
                            subScreenMainText: givenUserData,
                          };
                          print(body);
                          NetworkHelper req =
                              new NetworkHelper("$KBaseUrl/user/about");
                          var res = await req.putDataDio(body);
                          if (res.statusCode == 200) {
                            print(res.statusCode);
                          } else {
                            print(res.statusCode);
                            print(givenUserData);
                          }
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoadingScreen();
                          }));
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
        body: TextFormField(
          maxLines: null,
          onTap: () {
            setState(() {
              buttonText = 'Done';
            });
          },
          initialValue: (isSubScreenSubTextEmpty == true)
              ? null
              : widget.subScreenSubText,
          // controller: TextEditingController()
          //   ..text = (isSubScreenSubTextEmpty == true)
          //       ? null
          //       : widget.subScreenSubText,
          onChanged: (value) {
            givenUserData = value;
          },
          decoration: InputDecoration(
            isDense: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: (isSubScreenSubTextEmpty == true)
                ? "   " + widget.subScreenSubText + "..."
                : null,
            hintText: (isSubScreenSubTextEmpty == true)
                ? null
                : widget.subScreenSubText,
          ),
        ),
      ),
    );
  }
}
