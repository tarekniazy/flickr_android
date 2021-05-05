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


const KEmailHyperlinkedTexts = TextStyle(
  color: KFlickrNormalBlueColor,
  fontSize: 16.0,
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


Icon KEmailIcon =
Icon(
//FontAwesomeIcons.flickr,
FontAwesomeIcons.solidEnvelope,
color: kIconColor,
size: KSizeOfIconMail,
);

Icon kCorrectIcon =
Icon(
//FontAwesomeIcons.flickr,
  FontAwesomeIcons.check,
  color: kEmailGreyColor,
  size: KSizeOfIconCorrect,
);

Icon kCorrectIconLarge =
Icon(
//FontAwesomeIcons.flickr,
  FontAwesomeIcons.check,
  color: kIconColor,
  size: KSizeOfIconCorrectLarge,
);

Icon kSearchIcon =
Icon(
//FontAwesomeIcons.flickr,
  FontAwesomeIcons.search,
  color: kSearchIconColor,
  size: KSizeOfIconSearch,
);

// Icon kSearchIconLarge =
// Icon(
// //FontAwesomeIcons.flickr,
//   FontAwesomeIcons.search,
//   color: kSearchIconColor,
//   size: KSizeOfIconSearchLarge,
// );


Icon kSearchIconLarge = Icon(
Icons.search,
size: 70,
color: Colors.grey[400],
);



TextStyle selectedText= TextStyle (
shadows: [
Shadow(
color: Colors.black,
offset: Offset(0, -5))
],

decorationThickness: 2,
decoration: TextDecoration.underline,
decorationColor: Colors.black,
fontSize: 20,
color: Colors.transparent,
);