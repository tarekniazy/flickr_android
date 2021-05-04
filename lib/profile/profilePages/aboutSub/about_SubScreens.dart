import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';

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
                      onPressed: () {},
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
