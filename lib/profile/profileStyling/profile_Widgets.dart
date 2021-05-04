import 'package:flutter/material.dart';

const KTabBarTextsStyle = TextStyle(
  color: Colors.black,
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);

Widget createAboutTextTile({
  String mainText,
  String subText,
  String thirdText = '',
  bool thirdLine = false,
}) {
  return ListTile(
    shape: Border.all(),
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Colors.grey[400],
      size: 20.0,
    ),
    title: Text(
      mainText,
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    subtitle: (thirdLine == false)
        ? Text(
            subText + "...",
            style: TextStyle(fontSize: 16.0),
          )
        : RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: subText + '...\n',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16.0)),
              TextSpan(
                  text: thirdText,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.grey[600]))
            ]),
          ),
    isThreeLine: thirdLine,
  );
}
