import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr_android/constants.dart';
import 'package:flickr_android/profile/profileStyling/profile_Widgets.dart';

Widget BuildAbout() => SingleChildScrollView(
      child: Container(
        color: KAboutBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                createAboutTextTile(
                    mainText: 'Description', subText: 'Add Description'),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Occupation', subText: 'Add Occupation'),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'CurrentCity',
                    subText: 'Add Current City',
                    thirdText: 'Visible to: Anyone',
                    thirdLine: true),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Homtown', subText: 'Add Homtown'),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Website', subText: 'Add Website'),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(mainText: 'Tumblr', subText: 'Add Tumblr'),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Facebook', subText: 'Add Facebook'),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Twitter', subText: 'Add Twitter'),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Instagram', subText: 'Add Instagram'),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Pinterest', subText: 'Add Pinterest'),
                Divider(
                  color: Colors.grey[500],
                ),
                createAboutTextTile(
                    mainText: 'Email',
                    subText: 'Arwa@gmail.com',
                    thirdText: 'Visible to: People You Follow',
                    thirdLine: true),
              ],
            ),
          ),
        ),
      ),
    );
