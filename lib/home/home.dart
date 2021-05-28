import 'dart:core';
import 'package:flickr_android/Services/networking.dart';
import 'package:flickr_android/constants.dart';
import 'package:flickr_android/home/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'explore/explore.dart';
import 'package:flickr_android/profile/profile_screen.dart';
import 'search/search.dart';
import 'dart:convert';


class Home extends StatefulWidget {

Home({
  @required this.exploreImages,
});


final  List<dynamic> exploreImages;


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget view ;

  var exploreClicked = 1;
  var searchClicked = 0;
  var notificationClicked = 0;
  var profileClicked = 0;
  var cameraClicked = 0;

  Color bottonClicked(var button) {
    if (button == 1) {
      return Colors.white;
    } else {
      return Colors.white38;
    }
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    view=Explore(exploreImages: widget.exploreImages,);


  }



  void getExploreData() async
  {
    NetworkHelper req = new NetworkHelper("$KBaseUrl/image/explore");
    var res = await req.getData();
    print(res.statusCode);
    if (res.statusCode == 200)
    {
      String data = res.body;
      List<dynamic> response = jsonDecode(data);
      view = Explore(exploreImages: response);
    } else
    {
      print(res.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: view,
          backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Container(),
          actions: <Widget>[

            Expanded(
              child: IconButton(
                  icon: Icon(
                    Icons.image,
                    size: 30,
                    color: bottonClicked(exploreClicked),

                  ),
                  onPressed: () async {

                    NetworkHelper req = new NetworkHelper("$KBaseUrl/image/explore");
                    var res = await req.getData();
                    print(res.statusCode);
                    if (res.statusCode == 200)
                    {
                      String data = res.body;
                      List<dynamic> response = jsonDecode(data);
                      // response.forEach((element) => print(element));
                      view = Explore(exploreImages: response);
                    } else
                    {
                      print(res.statusCode);
                    }



                    setState(() {
                      exploreClicked = 1;
                      searchClicked = 0;
                      notificationClicked = 0;
                      profileClicked = 0;
                      cameraClicked = 0;

                      // view = Explore();

                    });
                  }),
            ),

            //  SizedBox(width: 40,),

            Expanded(
              child: IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: bottonClicked(searchClicked),
                  ),
                  onPressed: () {
                    setState(() {
                      exploreClicked = 0;
                      searchClicked = 1;
                      notificationClicked = 0;
                      profileClicked = 0;
                      cameraClicked = 0;

                      //TODO Mariam
                       view = Search();
                    });



                  }),
            ),

            // SizedBox(width: 40,),
            //

            Expanded(
              child: IconButton(
                  icon: Icon(
                    Icons.account_circle,
                    size: 30,
                    color: bottonClicked(profileClicked),
                  ),
                  onPressed: () {

                    setState(() {
                      exploreClicked = 0;
                      searchClicked = 0;
                      notificationClicked = 0;
                      profileClicked = 1;
                      cameraClicked = 0;
                    });
                    //Navigator.pushReplacementNamed(context, 'Profile');
                    view = Profile();
                  }),
            ),
            //    SizedBox(width: 40,),

            Expanded(
              child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: bottonClicked(notificationClicked),
                  ),
                  onPressed: () {
                    setState(() {
                      exploreClicked = 0;
                      searchClicked = 0;
                      notificationClicked = 1;
                      profileClicked = 0;
                      cameraClicked = 0;
                      view = Notifications();
                    });
                  }),
            ),

            //  SizedBox(width: 40,),

            Expanded(
              child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: bottonClicked(cameraClicked),
                  ),
                  onPressed: () {

                    setState(() {
                      exploreClicked = 0;
                      searchClicked = 0;
                      notificationClicked = 0;
                      profileClicked = 0;
                      cameraClicked = 1;

                      //TODO Mariam

                    });

                  }),
            ),
          ],
        ),
      ),
    );
  }
}
