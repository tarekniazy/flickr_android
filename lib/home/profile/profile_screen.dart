import 'dart:convert';
// import 'profilePages/camera.dart';
import 'package:flickr_android/home/profile/profilePages/Albums/albums.dart';
import 'package:flickr_android/home/profile/profilePages/cameraRoll/camera_Roll.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profileStyling/profile_Widgets.dart';
import 'profilePages/about_Screen.dart';
import 'package:flickr_android/Services/networking.dart';
import 'package:flickr_android/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'followers_following_screen.dart';



/// This the main UI of the Profile Screen that display - Profile Picture - name - number of followers - number of Photos
/// It displays [BuildAbout] -- About Screen
/// It displays [Albums]
/// It displays [CameraRoll]
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      homeTown = "  ";
  int photosCount = 0, followingCount = 0, followersCount = 0;

  void getUserDetails() async {
    NetworkHelper req = new NetworkHelper("$KBaseUrl/user");
    var res = await req.getData(true);
    if (res.statusCode == 200) {
      print('get Success');
      print(res.body);
      var json = jsonDecode(res.body);
      setState(() {
        firstName = json['Fname'];
        lastName = json['Lname'];
        avatarUrl = json['Avatar'];
        coverUrl = json['BackGround'];
        email = json['Email'];
        description = json['About']['Description'];
        occupation = json['About']['Occupation'];
        currentCity = json['About']['CurrentCity'];
        homeTown = json['About']['Hometown'];
        photosCount = json['Photo'];
        followingCount = json['Following'].length;
        followersCount = json['Followers'].length;
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
            email: element['Email'],
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
            email: element['Email'],
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
                    // leading: IconButton(
                    //   icon: Icon(
                    //     Icons.autorenew,
                    //     color: Colors.grey[800],
                    //   ),
                    // ),
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
                                          print(email);
                                        },
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
                          'About',
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
                          'Albums',
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
                BuildAbout(
                  context: context,
                  description: description,
                  occupation: occupation,
                  currentCity: currentCity,
                  homeTown: homeTown,
                  email: email,
                  photosCount: photosCount,
                ),
                CameraRoll(),
                Albums(),
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

