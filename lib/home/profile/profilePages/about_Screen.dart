import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import '../profilePages/../profileStyling/profile_Widgets.dart';

Widget BuildAbout(BuildContext context) => SingleChildScrollView(
      child: Container(
        color: KAboutBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                createAboutTextTile(
                    mainText: 'Description',
                    subText: 'Add Description',
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Occupation',
                    subText: 'Add Occupation',
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'CurrentCity',
                    subText: 'Add Current City',
                    thirdText: 'Visible to: Anyone',
                    thirdLine: true,
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Homtown',
                    subText: 'Add Homtown',
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Website',
                    subText: 'Add Website',
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Tumblr',
                    subText: 'Add Tumblr',
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Facebook',
                    subText: 'Add Facebook',
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Twitter',
                    subText: 'Add Twitter',
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Instagram',
                    subText: 'Add Instagram',
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Pinterest',
                    subText: 'Add Pinterest',
                    context: context),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Email',
                    subText: 'Arwa@gmail.com',
                    thirdText: 'Visible to: People You Follow',
                    thirdLine: true,
                    context: context),
              ],
            ),
          ),
        ),
      ),
    );
