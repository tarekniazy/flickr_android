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

class Profile extends StatefulWidget {
  Profile({
    @required this.firstName,
    @required this.lastName,
    @required this.avatarUrl,
    @required this.coverUrl,
    @required this.email,
    @required this.description,
    @required this.occupation,
    @required this.currentCity,
    @required this.homeTown,
    @required this.photosCount,
    @required this.followingCount,
    @required this.followersCount,
    // @required this.currentCity,
  });

  String firstName,
      lastName,
      avatarUrl,
      coverUrl,
      email,
      description,
      occupation,
      currentCity,
      homeTown;
  int photosCount, followingCount = 0, followersCount = 0;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<UserCard> usersListFollowing = [];
  List<UserCard> usersListFollowers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserFollowers();
    getUserFollowing();
  }

  void loadUserCardFollowing(List<dynamic> users) {
    setState(() {
      usersListFollowing.clear();
      users.forEach((element) {
        usersListFollowing.add(
          UserCard(
            userName: element["UserName"],
            avatar: element["Avatar"],
            photo: element["Photo"].toString(),
            followers: element["Followers"].toString(),
          ),
        );
      });
    });
  }

  void loadUserCardFollowers(List<dynamic> users) {
    setState(() {
      usersListFollowers.clear();
      users.forEach((element) {
        usersListFollowers.add(
          UserCard(
            userName: element["UserName"],
            avatar: element["Avatar"],
            photo: element["Photo"].toString(),
            followers: element["Followers"].toString(),
          ),
        );
      });
    });
  }

  void getUserFollowing() async {
    NetworkHelper req = new NetworkHelper("$KBaseUrl/user/following");
    var peopleresp = await req.getData(true);
    if (peopleresp.statusCode == 200) {
      String data2 = peopleresp.body;
      Map<String, dynamic> response2 = jsonDecode(data2);
      print(peopleresp.body);
      loadUserCardFollowing(response2['FollowingList']);
    } else {
      print(peopleresp.statusCode);
    }
  }

  void getUserFollowers() async {
    NetworkHelper req = new NetworkHelper("$KBaseUrl/user/followers");
    var peopleresp = await req.getData(true);
    if (peopleresp.statusCode == 200) {
      String data2 = peopleresp.body;
      Map<String, dynamic> response2 = jsonDecode(data2);
      print(peopleresp.body);
      loadUserCardFollowers(response2['FollowersList']);
    } else {
      print(peopleresp.statusCode);
    }
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
                      PopupMenuButton(
                        color: Colors.grey[700],
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            child: ListTile(
                              onTap: () async {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              title: Text(
                                'Signout',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
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
                            widget.coverUrl,
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
                                              widget.photosCount.toString() +
                                              ' of 1000 photos',
                                          textAlign: TextAlign.center),
                                    ),
                                    const PopupMenuDivider(),
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: () async {
                                          var status =
                                              await Permission.camera.status;
                                          // if (status.isGranted) {
                                          //   Navigator.push(context,
                                          //       MaterialPageRoute(
                                          //           builder: (context) {
                                          //     return CameraApp();
                                          //   }));
                                          // }
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
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: () {
                                          print(widget.email);
                                        },
                                        title: Text('Edit Cover Photo',
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundImage: NetworkImage(widget.avatarUrl),
                                radius: 20.0,
                              ),
                              Text(
                                widget.firstName + widget.lastName,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.grey[800]),
                              ),
                              Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        getUserFollowers();
                                      });
                                      print(usersListFollowers.length);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Folllwers_Following(
                                              peopleType: "Followers",
                                              people: usersListFollowers,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'followers ' +
                                          '${widget.followersCount}' +
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
                                    onTap: () async {
                                      setState(() {
                                        getUserFollowing();
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Folllwers_Following(
                                              peopleType: "Following",
                                              people: usersListFollowing,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'following ' +
                                          widget.followingCount.toString(),
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
                BuildAbout(
                    context,
                    widget.description,
                    widget.occupation,
                    widget.currentCity,
                    widget.homeTown,
                    widget.email,
                    widget.photosCount),
                CameraRoll(), //TODO Mariam- erase that text only and Return a widget for camera roll (hwa bl length fa deleting another text 7yedy error)
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
