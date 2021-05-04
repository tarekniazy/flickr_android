import 'package:flutter/material.dart';
import 'profileStyling/profile_Widgets.dart';

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
                    backgroundColor: Colors.black,
                    leading: new Container(),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://wallpaperaccess.com/full/900605.jpg'),
                            radius: 35.0,
                          ),
                        ],
                      ),
                    ),
                    bottom: TabBar(
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
                Text('hiii'),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
              ]),
        ),
      ),
    );
  }
}

// SafeArea(
// child: DefaultTabController(
// length: 6,
// child: Scaffold(
// body: CustomScrollView(
// slivers: <Widget>[
// // Add the app bar to the CustomScrollView.
// SliverAppBar(
// flexibleSpace: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text(
// 'yaaaaaayyfthgfghfhgaaay',
// style: TextStyle(
// color: Colors.white,
// ),
// ),
// ],
// ),
// backgroundColor: Colors.black,
// leading: new Container(),
// actions: <Widget>[
// Expanded(
// child: IconButton(
// icon: Icon(
// Icons.image,
// size: 30,
// color: bottonClicked(exploreClicked),
// ),
// onPressed: () {
// setState(() {
// exploreClicked = 1;
// searchClicked = 0;
// notificationClicked = 0;
// profileClicked = 0;
// cameraClicked = 0;
// });
// }),
// ),
// Expanded(
// child: IconButton(
// icon: Icon(
// Icons.search,
// size: 30,
// color: bottonClicked(searchClicked),
// ),
// onPressed: () {
// setState(() {
// exploreClicked = 0;
// searchClicked = 1;
// notificationClicked = 0;
// profileClicked = 0;
// cameraClicked = 0;
//
// //TODO Mariam
// });
// }),
// ),
// Expanded(
// child: IconButton(
// icon: Icon(
// Icons.account_circle,
// size: 30,
// color: bottonClicked(profileClicked),
// ),
// onPressed: () {
// setState(() {
// exploreClicked = 0;
// searchClicked = 0;
// notificationClicked = 0;
// profileClicked = 1;
// cameraClicked = 0;
// });
// }),
// ),
// Expanded(
// child: IconButton(
// icon: Icon(
// Icons.notifications,
// size: 30,
// color: bottonClicked(notificationClicked),
// ),
// onPressed: () {
// setState(() {
// exploreClicked = 0;
// searchClicked = 0;
// notificationClicked = 1;
// profileClicked = 0;
// cameraClicked = 0;
// });
// }),
// ),
// Expanded(
// child: IconButton(
// icon: Icon(
// Icons.camera_alt,
// size: 30,
// color: bottonClicked(cameraClicked),
// ),
// onPressed: () {
// setState(() {
// exploreClicked = 0;
// searchClicked = 0;
// notificationClicked = 0;
// profileClicked = 0;
// cameraClicked = 1;
//
// //TODO Mariam
// });
// }),
// ),
// ],
// bottom: TabBar(
// isScrollable: true,
// tabs: [
// Text('hiii'),
// Text('heeeei'),
// Text('heeeei'),
// Text('heeeei'),
// Text('heeeei'),
// Text('heeesssssssei'),
// ],
// ),
// floating: true,
// expandedHeight: 200,
// )
// ],
// ),
// ),
// ),
// );

// Expanded(
//   child: Image(
//     image: NetworkImage(
//         "https://wallpaperaccess.com/full/900605.jpg"),
//     width: double.infinity,
//     height: 50.0,
//   ),
// ),
