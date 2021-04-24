import 'package:flickr_android/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const KFlickrTextStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
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
