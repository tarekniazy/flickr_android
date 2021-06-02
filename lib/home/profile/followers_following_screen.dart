import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  UserCard({
    @required this.userName,
    @required this.photo,
    @required this.avatar,
  });

  final String userName;
  final String photo;
  final avatar;

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: ListTile(
        leading: Container(
          width: 50,
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
        subtitle: Text('${widget.photo ?? 0}' + ' photos — '),
        trailing: Container(
          width: 80.0,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
            child: Text(
              '+ Follow',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
