import 'package:flickr_android/home/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'explore/explore.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget view=Explore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: view,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: <Widget>[

            IconButton(
                icon: Icon(
                  Icons.image,
                  size: 30,
                ),
                onPressed: (){
                  setState(() {
                    view=Explore();
                  });

                }
            ),


            SizedBox(width: 40,),

            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                onPressed: (){}
            ),

            SizedBox(width: 40,),


            IconButton(
                icon: Icon(
                    Icons.account_circle,
                   size: 30,
                ),
                onPressed: (){}
            ),
            SizedBox(width: 40,),

            IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 30,
                ),
                onPressed: (){
                  setState(() {
                    view=Notifications();
                  });

                }
            ),


            SizedBox(width: 40,),


            IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  size: 30,
                ),
                onPressed: (){}
            ),

          ],
        ),
      ),
    );
  }
}


