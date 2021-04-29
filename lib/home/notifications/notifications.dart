import 'package:flutter/material.dart';


class Default extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget> [

        SizedBox(
          height: 220,
        ),

        Center(
          child: Icon(
            Icons.notifications,
            size: 80,
            color: Colors.grey[400],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Welcome to Flickr!",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Frutiger',
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),


        Center(
          child: Text(
            "Whenever friends follow you or fav",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Frutiger',
              color: Colors.grey[400],
              fontWeight: FontWeight.normal,
            ),
          ),
        ),


        Center(
          child: Text(
            "your photos,you'll get a notification",

            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Frutiger',
              color: Colors.grey[400],
              fontWeight: FontWeight.normal,
            ),
          ),
        ),

        Center(
          child: Text(
                "here.",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Frutiger',
              color: Colors.grey[400],
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}





class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Default();
  }
}
