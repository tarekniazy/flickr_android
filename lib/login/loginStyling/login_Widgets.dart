import 'package:flickr_android/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



const KFlickrTextStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);

const KHyperlinkedTexts = TextStyle(
  color: KFlickrNormalBlueColor,
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

const KOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(4),
  ),
);

const KOutlineInputBorderFocused = OutlineInputBorder(
  borderSide: BorderSide(
    width: 0.8,
    color: KFlickrNormalBlueColor,
  ),
);

ClipRRect kClipRRect = ClipRRect(
  borderRadius: BorderRadius.circular(5.0),
  child: Container(
    height: 40.0,
    color: KWarningColor,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        KWarningText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    ),
  ),
);

// Returns a row that contains the flickr Icon
Row KFlickrIcon = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Icon(
      //FontAwesomeIcons.flickr,
      FontAwesomeIcons.solidCircle,
      color: Colors.blue[800],
      size: KSizeOfIcon,
    ),
    SizedBox(
      width: 2.0,
    ),
    Icon(
      //FontAwesomeIcons.flickr,
      FontAwesomeIcons.solidCircle,
      color: Colors.pinkAccent,
      size: KSizeOfIcon,
    ),
  ],
);
