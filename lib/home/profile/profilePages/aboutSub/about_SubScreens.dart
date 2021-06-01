import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'package:flickr_android/Services/networking.dart';
import 'package:flickr_android/home/customeWidgets.dart';

class AboutSubscreen extends StatefulWidget {
  AboutSubscreen(this.subScreenMainText, this.subScreenSubText,
      this.isSubScreenSubTextEmpty, this.visibility);
  final subScreenMainText;
  final subScreenSubText;
  final isSubScreenSubTextEmpty;
  final visibility;
  @override
  _AboutSubscreenState createState() => _AboutSubscreenState(
      subScreenMainText, subScreenSubText, isSubScreenSubTextEmpty, visibility);
}

class _AboutSubscreenState extends State<AboutSubscreen> {
  _AboutSubscreenState(this.subScreenMainText, this.subScreenSubText,
      this.isSubScreenSubTextEmpty, this.visibility);
  final subScreenMainText;
  final subScreenSubText;
  final isSubScreenSubTextEmpty;
  bool buttonBoolean = false;
  bool visibility;
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
        body: Column(children: <Widget>[
          Visibility(
            visible: !visibility,
            child: TextFormField(
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
          Visibility(
              visible: visibility,
              child: Container(
                width: double.infinity,
                color: Colors.grey[300],
                height: 60.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "  " + subScreenSubText,
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
              )),
          Visibility(
            visible: visibility,
            child: ListTile(
              shape: Border.all(),
              trailing: Text('People you may know'),
              title: Text(
                'Visible to:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[500],
          ),
        ]),
      ),
    );
  }
}
