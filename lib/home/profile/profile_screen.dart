import 'dart:convert';

import 'package:flickr_android/home/profile/profilePages/Albums/albums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profileStyling/profile_Widgets.dart';
import 'profilePages/about_Screen.dart';
import 'package:flickr_android/Services/networking.dart';
import 'package:flickr_android/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String firstName,
      lastName,
      avatarUrl,
      coverUrl,
      email,
      description,
      occupation,
      currentCity,
      homeTown;
  int photosCount = 0, followingCount = 0, followersCount = 0;

  void getUserDetails() async {
    NetworkHelper req = new NetworkHelper("$KBaseUrl/user");
    var res = await req.getData();
    if (res.statusCode == 200) {
      print('get Success');
      print(res.body);
      setState(() {
        var json = jsonDecode(res.body);
        firstName = json['Fname'];
        lastName = json['Lname'];
        avatarUrl = json['Avatar'];
        coverUrl = json['BackGround'];
        description = json['Description'];
        occupation = json['Occupation'];
        currentCity = json['CurrentCity'];
        homeTown = json['Hometown'];
        //photosCount = json['Photo'];
        //followingCount = json['Following'];
        //followersCount = json['Followers'];
      });
    } else {
      print(res.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: DefaultTabController(
        length: 5, // This is the number of tabs.
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    expandedHeight: 220,
                    floating: true,
                    pinned: true,
                    backgroundColor: Colors.white,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.ellipsisV,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                    leading: IconButton(
                      icon: Icon(
                        Icons.autorenew,
                        color: Colors.grey[800],
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        padding: EdgeInsets.only(bottom: 42.0),
                        child: FittedBox(
                          child: Image.network(
                            coverUrl,
                            color: Colors.black.withOpacity(0.5),
                            colorBlendMode: BlendMode.dstATop,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      centerTitle: true,
                      titlePadding: EdgeInsets.only(bottom: 42.0),
                      title: Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                child: PopupMenuButton(
                                  offset: Offset(-55.0, 20.0),
                                  icon: Icon(Icons.more_vert),
                                  iconSize: 0.0,
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry>[
                                    PopupMenuItem(
                                      child: Text(
                                          'Using ' +
                                              photosCount.toString() +
                                              ' of 1000 photos',
                                          textAlign: TextAlign.center),
                                    ),
                                    const PopupMenuDivider(),
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: () async {
                                          if (await Permission.contacts
                                              .request()
                                              .isGranted) {
                                            // Either the permission was already granted before or the user just granted it.
                                          }
                                          Map<Permission, PermissionStatus>
                                              statuses = await [
                                            // Permission.photos,
                                            Permission.camera,
                                          ].request();
                                          print(statuses[Permission.camera]);
                                        },
                                        title: Text('Edit Profile Photo',
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                    const PopupMenuDivider(),
                                    const PopupMenuItem(
                                      child: ListTile(
                                        title: Text('Edit Cover Photo',
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundImage: NetworkImage(avatarUrl),
                                radius: 20.0,
                              ),
                              Text(
                                firstName + lastName,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.grey[800]),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'followers ' + followersCount.toString(),
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey[800]),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'following ' + followingCount.toString(),
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey[800]),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      indicatorColor: Colors.grey[800],
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.grey[800],
                      // These are the widgets to put in each tab in the tab bar.
                      tabs: [
                        Text(
                          'About',
                          style: KTabBarTextsStyle,
                        ),
                        Text(
                          'Camera Roll',
                          style: KTabBarTextsStyle,
                        ),
                        Text(
                          'Public',
                          style: KTabBarTextsStyle,
                        ),
                        Text(
                          'Albums',
                          style: KTabBarTextsStyle,
                        ),
                        Text(
                          'Groups',
                          style: KTabBarTextsStyle,
                        ),
                      ],
                      isScrollable: true,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: [
                BuildAbout(context),
                Text(
                    ''), //TODO Mariam- erase that text only and Return a widget for camera roll (hwa bl length fa deleting another text 7yedy error)
                Text(''), //TODO Arwa- this text is For public
                Albums(), //TODO Tarek- erase that text only and Return a widget for Albums (hwa bl length fa deleting another text 7yedy error)
                Text(''), //TODO Tarek- this text is For Groups
              ]),
        ),
      ),
    );
  }
}

// background: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// CircleAvatar(
// backgroundImage: NetworkImage(
// 'https://wallpaperaccess.com/full/900605.jpg'),
// radius: 35.0,
// ),
// ],
// ),

// Text(
// 'Use Name',
// style: TextStyle(
// fontSize: 40.0,
// color: Colors.yellow,
// backgroundColor: Colors.yellow),
// ),
