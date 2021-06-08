import 'package:flutter/material.dart';
import 'package:flickr_android/home/profile/otherProfiles_screen.dart';

/// This widget preview the user Card - profile picture - name - followers - number of photos of the user
/// @userName : name of the user
/// @followers : number of followers
/// @photo : number of photos
/// @avatar : profile picture
/// @email : an identifier to the User
class UserCard extends StatefulWidget {
  UserCard(
      {@required this.userName,
      @required this.photo,
      @required this.avatar,
      @required this.followers,
      @required this.email});

  final String userName;
  final String photo;
  final avatar;
  final followers;
  String email;

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OhterProfile(email: widget.email);
          }));
        },
        leading: Container(
          width: 35,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(widget.avatar),
              )),
        ),
        title: Text(
          widget.userName,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Frutiger',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('${widget.photo ?? 0}' +
            ' photos — ' +
            widget.followers.toString() +
            ' Followers'),
      ),
    );
  }
}

class Folllwers_Following extends StatefulWidget {
  Folllwers_Following({
    @required this.people,
    @required this.peopleType,
  });
  final List<UserCard> people;
  final String peopleType;

  @override
  _Folllwers_FollowingState createState() => _Folllwers_FollowingState();
}

class _Folllwers_FollowingState extends State<Folllwers_Following> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(widget.peopleType),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: new ListView.builder(
            itemCount: widget.people.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.people[index];
            },
          ))
          // Text("data")
        ],
      ),
    ));
  }
}
