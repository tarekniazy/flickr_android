import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const KAppBarBackgroundColor = Color(0xFF212121);

const KFlickrTextStyle = TextStyle(
  fontSize: 35.0,
  fontWeight: FontWeight.bold,
);

// Returns a row that contains the flickr Icon
Row KFlickrIcon = Row(
  children: <Widget>[
    Icon(
      //FontAwesomeIcons.flickr,
      FontAwesomeIcons.solidCircle,
      color: Colors.blue,
      size: 20.0,
    ),
    Icon(
      //FontAwesomeIcons.flickr,
      FontAwesomeIcons.solidCircle,
      color: Colors.pinkAccent,
      size: 20.0,
    ),
  ],
);
