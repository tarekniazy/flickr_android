import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import '../profilePages/../profileStyling/profile_Widgets.dart';

Widget BuildAbout(
        {BuildContext context,
        String description,
        String occupation,
        String currentCity,
        String homeTown,
        String email,
        int photosCount,
        bool isOther = false}) =>
    SingleChildScrollView(
      child: Container(
        color: KAboutBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    photosCount.toString() + ' Photos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Description',
                    subText:
                        (description == null) ? 'Add Description' : description,
                    isSubEmptyText: (description == null) ? true : false,
                    context: context,
                    isOther: isOther),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Occupation',
                    subText:
                        (occupation == null) ? 'Add Occupation' : occupation,
                    isSubEmptyText: (occupation == null) ? true : false,
                    context: context,
                    isOther: isOther),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'CurrentCity',
                    subText:
                        (currentCity == null) ? 'Add CurrentCity' : currentCity,
                    isSubEmptyText: (currentCity == null) ? true : false,
                    thirdText: 'Visible to: Anyone',
                    thirdLine: true,
                    context: context,
                    isOther: isOther),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Hometown',
                    subText: (homeTown == null) ? 'Add Hometown' : homeTown,
                    isSubEmptyText: (homeTown == null) ? true : false,
                    context: context,
                    isOther: isOther),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Email',
                    subText: email,
                    thirdText: 'Visible to: People You Follow',
                    thirdLine: true,
                    visibility: true,
                    context: context),
              ],
            ),
          ),
        ),
      ),
    );
