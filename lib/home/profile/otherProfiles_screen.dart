import 'dart:convert';
// import 'profilePages/camera.dart';
import 'package:flickr_android/home/profile/profilePages/Albums/albums.dart';
import 'package:flickr_android/home/profile/profilePages/CameraRoll/camera_Roll.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profileStyling/profile_Widgets.dart';
import 'profilePages/about_Screen.dart';
import 'package:flickr_android/Services/networking.dart';
import 'package:flickr_android/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'followers_following_screen.dart';


/// This Screen Preview the screen profile of other User
/// @email : a unique identifier to get the user with it
/// preview - profile picture - name - background - no of followers - no of following - About Screen
class OhterProfile extends StatefulWidget {
  OhterProfile({@required this.email});
  final email;

  @override
  _OtherprofileState createState() => _OtherprofileState();
}

class _OtherprofileState extends State<OhterProfile> {
  List<UserCard> usersListFollowing = [];
  List<UserCard> usersListFollowers = [];

  String firstName = "  ",
      lastName = "  ",
      avatarUrl =
          "https://www.panelplus.co.th/uploads/collection/5be55-white-mk630n.jpg",
      coverUrl =
          "https://www.panelplus.co.th/uploads/collection/5be55-white-mk630n.jpg",
      email = "  ",
      description = "  ",
      occupation = "  ",
      currentCity = "  ",
      homeTown = "  ",
      id = null;
  int photosCount = 0, followersCount = 0, followingCount = 0;
  List<String> gallery = [];
  List<dynamic> followingList = [];
  List<dynamic> followersList = [];

  void getUserDetails() async {
    NetworkHelper req =
        new NetworkHelper("$KBaseUrl/people/" + (widget.email).toString());
    var res = await req.getData(true);
    if (res.statusCode == 200) {
      // print('get Success');
      // print(res.body);
      var json = jsonDecode(res.body);
      setState(() {
        firstName = json['Fname'];
        lastName = json['Lname'];
        avatarUrl = json['Avatar'];
        coverUrl = json['BackGround'];
        email = json['Email'];
        id = json['_id'];
        description = json['About']['Description'];
        occupation = json['About']['Occupation'];
        currentCity = json['About']['CurrentCity'];
        homeTown = json['About']['Hometown'];
        followingList = json['Following'];
        followersList = json['Followers'];
        followingCount = followingList.length;
        followersCount = followersList.length;
      });
    } else {
      print(res.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: DefaultTabController(
        length: 3, // This is the number of tabs.
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
                                  GestureDetector(
                                    child: Text(
                                      'followers ' +
                                          '${followersCount}' +
                                          '   -',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey[800]),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'following ' + followingCount.toString(),
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey[800]),
                                    ),
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
                          'Albums',
                          style: KTabBarTextsStyle,
                        ),
                        Text(
                          'Camera Roll',
                          style: KTabBarTextsStyle,
                        ),
                        // Text(
                        //   'Public',
                        //   style: KTabBarTextsStyle,
                        // ),
                        Text(
                          'About',
                          style: KTabBarTextsStyle,
                        ),
                        // Text(
                        //   'Groups',
                        //   style: KTabBarTextsStyle,
                        // ),
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
                Albums(),
                CameraRoll(),
                BuildAbout(
                  context: context,
                  description: description,
                  occupation: occupation,
                  currentCity: currentCity,
                  homeTown: homeTown,
                  email: email,
                  photosCount: photosCount,
                  isOther: true,
                ),
              ]),
        ),
      ),
    );
  }
}
