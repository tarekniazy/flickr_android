import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profileStyling/profile_Widgets.dart';
import 'profilePages/about_Screen.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    expandedHeight: 250,
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
                            "https://wallpaperaccess.com/full/900605.jpg",
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
                                backgroundImage: NetworkImage(
                                    'https://wallpaperaccess.com/full/900605.jpg'),
                                radius: 35.0,
                              ),
                              Text(
                                'User Name',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.grey[800]),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'followers 0',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey[800]),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'following 1',
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
                Text(
                    ''), //TODO Tarek- erase that text only and Return a widget for Albums (hwa bl length fa deleting another text 7yedy error)
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
