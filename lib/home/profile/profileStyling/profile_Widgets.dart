import 'package:flutter/material.dart';
import '../profilePages/aboutSub/about_SubScreens.dart';

const KTabBarTextsStyle = TextStyle(
  // color: Colors.black,
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);

Widget createAboutTextTile({
  String mainText,
  String subText,
  bool isSubEmptyText,
  int typeSelected,
  bool isOther,
  String thirdText = '',
  bool thirdLine = false,
  bool visibility = false,
  BuildContext context,
}) {
  return ListTile(
    shape: Border.all(),
    trailing: (isOther == false)
        ? Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey[400],
            size: 20.0,
          )
        : null,
    title: Text(
      mainText,
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    subtitle: (thirdLine == false)
        ? Text(
            (subText == "") ? ("add " + mainText + "...") : subText,
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
    onTap: () {
      if (isOther == false) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AboutSubscreen(
                  mainText, subText, isSubEmptyText, visibility);
            },
          ),
        );
      }
    },
  );
}
