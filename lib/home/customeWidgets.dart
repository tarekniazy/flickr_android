import 'dart:convert';
import 'dart:io';
import 'package:flickr_android/home/profile/profile_screen.dart';

import '../constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Services/networking.dart';

import 'profile/profilePages/Albums/albums.dart';

class ImageCard extends StatefulWidget {
  ImageCard({
    @required this.imageUrl,
    @required this.author,
    @required this.comments,
    @required this.faves,
    @required this.imageId,
    @required this.isfaved,
  });

  final String imageUrl; // image path
  final Map<String,dynamic> author; // author name
  final List<dynamic> comments;
  final List<dynamic> faves;
  final imageId;
  final isfaved;

  // final numberOfFaves; // number of likes
  // final numberOfComments; // number of comments
  // final String topComment; // top comment
  // final String usernameTopComment; // name of the user who made the top comment

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {

  String LastComment;
  String LastUser;
  Icon fav=Icon(Icons.star_border);

  int viewfaved=0;

  Text checkIfAvailble(int number) {
    if (number > 0) {
      return Text(
        '$number',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Frutiger',
          color: Colors.black54,
        ),
      );
    } else if (number == 0 || number == null) {
      return Text(
        ' ',
      );
    }
  }

  var like = 0;

  Icon likePressed()  {


    if (widget.isfaved==1)
      {

        return Icon(
          Icons.star,
          color: Colors.blue,
        );

      }
    else
      {
        return Icon(
          Icons.star_border,
        );
      }

  }


  String ifLastComment()
  {
    if(widget.comments.length!=0) {
      LastUser=widget.comments.last["user"]["Fname"];
      return widget.comments.last["comment"];
    }
    else
      {
        LastUser=" ";
        return " ";
      }

  }


  String ifLastUserComment()
  {
    if(widget.comments.length!=0) {
      return widget.comments.last["user"]["Fname"];
    }
    else
    {
      return " ";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ImageView(
                        imageUrl: widget.imageUrl,
                        authorId: widget.author["Fname"],
                        authorImage: widget.author["Avatar"],
                        faves: widget.faves,
                        comments: widget.comments,
                        isfaved: widget.isfaved,
                        imageId: widget.imageId,
                      );
                    },
                  ),
                );
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image(
                image: NetworkImage(widget.imageUrl),
              ),
            ),
          ),
          Card(
            child: ListTile(
                title: Text(
                  widget.author["Fname"],
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Frutiger',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Container(
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.author["Avatar"]),
                      )),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () async {

                  print(widget.isfaved);
                  if(widget.isfaved==1)
                    {
                      print("faaaaaaaaaaaaaaaved");

                      print(widget.imageId.runtimeType);


                      NetworkHelper req = new NetworkHelper("$KBaseUrl/favs/"+widget.imageId);

                      var res = await req.deleteData();

                      print(res.statusCode);


                      if (res.statusCode == 200) {
                        String data = res.body;
                        var response = jsonDecode(data);
                        print(response["message"]);

                      }
                      setState(() {
                        like=0;
                      });

                    }
                  else {
                    Map<String, dynamic> Body = {"photo_id": widget.imageId};

                      NetworkHelper req = new NetworkHelper("$KBaseUrl/favs");

                      setState(() {
                        like=1;
                      });

                      var res = await req.postData(Body,true);

                      if (res.statusCode == 200) {
                        String data = res.body;
                        var response = jsonDecode(data);
                        print(response["message"]);

                      }
                      else
                        {
                        print(res.statusCode);
                      }
                  }


                  // setState(() {
                  //   if (like == 1) {
                  //     like = 0;
                  //   } else {
                  //     like = 1;
                  //   }
                  // });
                },
                child: IconButton(

                  icon: likePressed() ,

                ),
              ),
              checkIfAvailble(widget.faves.length),
              IconButton(
                icon: Icon(
                  Icons.messenger_outline,
                  color: Colors.black45,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CommentView(
                          authorId:widget.author["Fname"],
                          faves: widget.faves,
                          comments: widget.comments);
                    }));
                  });
                },
              ),
              checkIfAvailble(widget.comments.length),
              IconButton(
                icon: Icon(
                  Icons.share,
                ),
              ),
            ],
          ),
          Card(
            color: Colors.white38,
            child: ListTile(
              leading: Icon(
                Icons.messenger,
                size: 20,
              ),
              title: Text(
               ifLastUserComment(),
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Frutiger',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: GestureDetector(
                child: Text(
                  ifLastComment(),
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Frutiger',
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CommentView(
                          authorId:" widget.authorId",
                          faves: widget.faves,
                          comments: widget.comments);
                    }));
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
            child: Container(
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class ImageView extends StatefulWidget {
  ImageView({
    @required this.imageUrl,
    @required this.authorId,
    @required this.authorImage,
    @required this.comments,
    @required this.faves,
    @required this.imageId,
    @required this.isfaved,
  });

  final String imageUrl; // image path
  final String authorId; // author name
  final String authorImage; // author home.profile pic
  final List<dynamic> comments;
  final List<dynamic> faves;
  final imageId;
  final isfaved;

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  // Icon like = Icon(
  //   Icons.star_border,
  //   size: 25,
  //   color: Color(0xFFFFFFFF),
  // );
  // bool likePressed = false;

  Icon likePressed()  {


    if (widget.isfaved==1)
    {

      return Icon(
        Icons.star,
        color: Colors.blue,
      );

    }
    else
    {
      return Icon(
        Icons.star_border,
        color: Colors.white,
      );
    }

  }

  // void Fav_unFave ()
  // {
  //   if (widget.)
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card(
                color: Colors.black54,
                child: ListTile(
                  title: Text(
                    widget.authorId,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Frutiger',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Container(
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(widget.authorImage),
                        )),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Image(
                  image: NetworkImage(widget.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: Card(
                  color: Colors.black,
                  child: Container(
                    height: 65,
                    child: Column(children: <Widget>[
                      Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                      Row(children: <Widget>[
                        IconButton(
                          onPressed: () async {
                            print(widget.isfaved);
                            if(widget.isfaved==1)
                            {
                              print("faaaaaaaaaaaaaaaved");
                            }
                            else {
                              Map<String, dynamic> Body = {"photo_id": widget.imageId};


                                NetworkHelper req = new NetworkHelper("$KBaseUrl/favs");

                                var res = await req.postData(Body,true);

                                if (res.statusCode == 200) {
                                  String data = res.body;
                                  var response = jsonDecode(data);
                                  print(response["message"]);
                                } else {
                                  print(res.statusCode);
                                }
                              }
                          },
                          icon: likePressed(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.messenger_outline,
                            size: 25,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CommentView(
                                    authorId: widget.authorId,
                                    faves: widget.faves,
                                    comments: widget.comments);
                              }));
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            size: 25,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            size: 25,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${widget.faves.length} faves",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Frutiger',
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    //        Navigator.push(context, MaterialPageRoute(builder: (context){
                                    //          return CommentView(authorId: widget.authorId,faves:widget.faves, comments: widget.comments);}));
                                  });
                                },
                                child: Text(
                                  "${widget.comments.length} comments",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Frutiger',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

class CommentView extends StatefulWidget {
  CommentView({
    @required this.authorId,
    @required this.comments,
    @required this.faves,
    // @required this.commentClicked
  });

  final String authorId; // author name
  final List<dynamic> comments;
  final List<dynamic> faves;
  // var commentClicked;

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  List<CommentCard> commentBody = [];

  List<UserCard> userBody = [];

  TextEditingController _controller = new TextEditingController();

  var commentViewed = 1;
  var favedViewed = 0;

  Widget commentOrFavs() {
    if (commentViewed == 1) {
      return CommentSection(
        comments: widget.comments,
        commentBody: commentBody,
        authorName: widget.authorId,
        favs: widget.faves,
      );
    } else if (commentViewed == 0) {
      return UserView(
        userBody: userBody,
      );
    }
  }

  void loadComments() {
    widget.comments.forEach((element) {
      {
        commentBody.add(CommentCard(
            authorId: element["user"]["Fname"],
            authorImage: element["user"]["Avatar"],
            comment: element["comment"]));
      }
    });
  }

  void loadFavs() {
    widget.faves.forEach((element) {
      {
        userBody.add(UserCard(
            authorName: element["Fname"],
            authorImage: element["Avatar"],
            numberOfPhotos: element["numPhotos"],
            numberOfFollowers: element["numFollowing"],
            favs: widget.faves));
      }
    });
  }

  TextStyle viewed(var check) {
    if (check == 1) {
      return TextStyle(
        shadows: [Shadow(color: Colors.black, offset: Offset(0, -10))],
        decorationThickness: 3,
        decoration: TextDecoration.underline,
        decorationColor: Colors.black,
        fontSize: 18,
        fontFamily: 'Frutiger',
        color: Colors.transparent,
        fontWeight: FontWeight.bold,
      );
    } else {
      return TextStyle(
        fontSize: 18,
        fontFamily: 'Frutiger',
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadComments();
    loadFavs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(
          widget.authorId + "'s photo",
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Frutiger',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 70,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      favedViewed = 1;
                      commentViewed = 0;
                    });
                  },
                  child: Text(
                    '${userBody.length}' + ' faves',
                    style: viewed(favedViewed),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      favedViewed = 0;
                      commentViewed = 1;
                    });
                  },
                  child: Text('${commentBody.length}' + ' comments',
                      style: viewed(commentViewed)),
                ),
              ],
            ),
          ),

          commentOrFavs(),
          // CommentSection(comments: widget.comments, commentBody: commentBody,authorName: widget.authorId,favs: widget.faves,),
          //       UserView(userBody: userBody,favs: widget.faves),
        ],
      ),
    ));
  }
}

class CommentCard extends StatefulWidget {
  CommentCard({
    @required this.authorId,
    @required this.authorImage,
    @required this.comment,
  });

  final String authorId; // author name
  final String authorImage; // author home.profile pic
  final String comment; // top comment

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, top: 20),
        child: ListTile(
          leading: Container(
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.authorImage),
                )),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.authorId,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Frutiger',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                child: Text(
                  widget.comment,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Frutiger',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Reply",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Frutiger',
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserCard extends StatefulWidget {
  UserCard(
      {@required this.authorName,
      @required this.authorImage,
      @required this.numberOfPhotos,
      @required this.numberOfFollowers,
        @required this.isFollowed,
        @required this.peopleID,
      @required this.favs});

  final String authorName; // author name
  final String authorImage; // author home.profile pic
  final numberOfPhotos;
  final numberOfFollowers;
  final isFollowed;
  final peopleID;
  final List<dynamic> favs;

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool textToggle = false;
  bool followed;
  String text = '+ Follow';

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      // tileColor: Colors.grey[300],
      child: ListTile(
        leading: Container(
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(widget.authorImage),
              )),
        ),
        title: Text(
          widget.authorName,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Frutiger',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
            '${widget.numberOfPhotos ?? 0 }' +
            ' photos — ' +
            '${widget.numberOfFollowers ?? 0}' +
            ' followers'),
        trailing: Container(
          width: (textToggle == false) ? ((widget.isFollowed == true) ? 35.0 : 80.0) : ((followed == true) ? 35.0 : 80.0),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
            onPressed: () async {
              if (widget.isFollowed == false || followed == false) {
                Map<String, dynamic> Body = {
                  "peopleid": widget.peopleID,
                };
                print(widget.peopleID);
                NetworkHelper req = new NetworkHelper("$KBaseUrl/user/follow");
                var peopleresp = await req.postData(Body, true);
                print(peopleresp.statusCode);
                if (peopleresp.statusCode == 200)
                  {
                  setState(() {
                    text = '✔';
                    followed =  true;
                    textToggle = true;
                  });
                  }
                  }

              else
                {
                  NetworkHelper req = new NetworkHelper("$KBaseUrl/user/unfollow/"+widget.peopleID);
                  var peopleresp = await req.deleteData();
                  print(peopleresp.statusCode);
                  if(peopleresp.statusCode == 200)
                    {
                      setState(() {
                        text = '+ Follow';
                        followed = false;
                        textToggle = true;
                      });
                    }

                }

              setState(() {
                if (widget.isFollowed == false) {
                  if (widget.favs != null) {
                    widget.favs.forEach((element) {
                      var count = element["num_following"];
                      print(count.runtimeType);
                      // count++;
                      // element["num_following"] = '$count';
                    });
                  }

                }
              });
            },
            child: Text(
              //text,
              (textToggle==false) ? ((widget.isFollowed == false) ? '+ Follow' : '✔') : text,
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

class UserView extends StatefulWidget {
  UserView({
    @required this.userBody,
  });

  final List<dynamic> userBody;

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
                child: new ListView.builder(
              itemCount: widget.userBody.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.userBody[index];
              },
            )),
          ],
        ),
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  CommentSection({
    @required this.comments,
    @required this.commentBody,
    @required this.authorName,
    @required this.favs,
  });

  final List<dynamic> comments;
  final List<CommentCard> commentBody;
  final List<dynamic> favs;
  final String authorName;

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  TextEditingController _controller = new TextEditingController();

  String firstName,
      lastName,
      avatarUrl,
      coverUrl,
      email,
      description,
      occupation,
      currentCity,
      homeTown;
  int photosCount = 0, followingCount = 0, followersCount = 0;

  void getUserDetails() async {
    NetworkHelper req = new NetworkHelper("$KBaseUrl/user");
    var res = await req.getData(true);
    if (res.statusCode == 200) {
      print('get Success');
      print(res.body);
      var json = jsonDecode(res.body);
      // sleep(const Duration(seconds: 5));

      // setState(() {
      // if (json!=null) {



      firstName = json['Fname'];
      lastName = json['Lname'];
      avatarUrl = json['Avatar'];
      coverUrl = json['BackGround'];
      description = json['Description'];
      occupation = json['Occupation'];
      currentCity = json['CurrentCity'];
      homeTown = json['Hometown'];
      // print(avatarUrl);
      photosCount = json['Photo'];
      followingCount = json['Following'];
      followersCount = json['Followers'];
      // }
      // });
      //
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
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
                child: new ListView.builder(
              itemCount: widget.commentBody.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.commentBody[index];
              },
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0xFFE6E6E6),
                child: ListTile(
                  title: TextField(
                    controller: _controller,

                    // onChanged: (str) async{
                    //
                    // },

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write a comment...",
                      helperStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Frutiger',
                        color: Color(0xFF606060),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      setState(() {
                        print(_controller.text);

                        widget.commentBody.add(CommentCard(
                            authorId: firstName,
                            authorImage: avatarUrl,
                            comment: _controller.text));
                        widget.comments.add({
                          "id": 0,
                          "comment": _controller.text,
                          "user": {
                            "_id": 0,
                            "Fname": firstName,
                            "Lname": lastName,
                            "UserName": "Mostafa123",
                            "Email": "test@test.com",
                            "Avatar": avatarUrl
                          },
                        });

                        print(widget.comments);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => CommentView(
                                      authorId: widget.authorName,
                                      comments: widget.comments,
                                      faves: widget.favs,
                                    )));

                        _controller.clear();
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 3),
                        ),
                      ), //MaterialProperty
                    ),
                    child: Text(
                      "Post",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Frutiger',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupCard extends StatefulWidget {
  GroupCard({
    @required this.authorName,
    @required this.authorImage,
    @required this.numberOfPhotos,
    @required this.numberOfMembers,
  });

  final String authorName; // author name
  final String authorImage; // author home.profile pic
  final numberOfPhotos;
  final numberOfMembers;

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  bool followed = false;
  String text = '+ Follow';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(12.0, 11.0, 12.0, 6.0),
      height: 105,
      child: Row(
        children: <Widget>[
          Container(
            height: 78,
            width: 105,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: NetworkImage(widget.authorImage),
                )),
          ),
          SizedBox(
            width: 2,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 17.0, 0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 210,
                    child: Text(
                      widget.authorName,
                      maxLines: 2,
                      // textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Frutiger',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      widget.numberOfMembers + ' members',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Frutiger',
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      widget.numberOfPhotos + ' photos',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Frutiger',
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlbumCard extends StatefulWidget {

  AlbumCard({
    @required this.AlbumName,
    @required this.dateCreated,
    @required this.photos,
    @required this.imageUrl,
  });


  final String AlbumName;
  final String dateCreated;
  final List<dynamic> photos;
  final String imageUrl;

  @override
  _AlbumCardState createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  @override


  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AlbumView(
                    AlbumName: widget.AlbumName,
                    photos: widget.photos,
                  );
                },
              ),
            );
          });
        },
        child: Container(
          height: 100,
          color: Colors.white,
         child: Row(
           children:<Widget> [
             Image(
               width: 100,
               height: 100,
               fit: BoxFit.fill,
                 image:NetworkImage(
                   widget.imageUrl,
                 ),
             ),

             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                 children:<Widget> [
                   Padding(
                     padding: const EdgeInsets.only(left: 10,top: 10),
                     child: Text(
                 widget.AlbumName,
                       style: TextStyle(
                           fontWeight: FontWeight.bold,
                         fontFamily: 'Frutiger',
                         color: Colors.black,
                         fontSize: 17,
                       ),
               ),
                   ),

               Expanded(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children:<Widget> [
                     Padding(
                       padding: const EdgeInsets.only(left: 8),
                       child: Text(
                       widget.dateCreated,
                       style: TextStyle(
                         fontFamily: 'Frutiger',
                         color: Color(0xFF8F8F8F),
                         fontSize: 17,
                         fontWeight: FontWeight.bold,

                       ),
                   ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 8),
                       child: Text(
                       '${widget.photos.length}'+' photos',
                       style: TextStyle(
                         fontFamily: 'Frutiger',
                         color: Color(0xFF8F8F8F),
                         fontSize: 17,
                         fontWeight: FontWeight.bold,

                       ),
                   ),
                     ),
                  ]
                 ),
               ),
             ]
             )

           ],
         ),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

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

  void getUserDetails() async {
    NetworkHelper req = new NetworkHelper("$KBaseUrl/user");
    var res = await req.getData(true);
    if (res.statusCode == 200) {
      print('get Success');
      print(res.body);
      var json = jsonDecode(res.body);
      // sleep(const Duration(seconds: 5));

      // setState(() {
     // if (json!=null) {



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
      // print(photosCount);
      // print( json['Following'].length);
      // print(json['Followers'].length);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Profile(
          firstName: firstName,
          lastName: lastName,
          avatarUrl: avatarUrl,
          coverUrl: coverUrl,
          email: email,
          description: description,
          occupation: occupation,
          currentCity: currentCity,
          homeTown: homeTown,
          photosCount: photosCount,
          followersCount: followersCount,
          followingCount: followingCount,
        );
      }));
      // }
      // });
    //


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

    );
  }
}
class PhotoCard extends StatefulWidget {

  PhotoCard({
    @required this.imageUrl,
  });

  final String imageUrl;

  @override
  _PhotoCardState createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  @override


  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0,4.0,4.0,0.0),
      child: Container(
        height: 150,
        color: kBackgroundColor,
        child: GestureDetector(
           onTap: () {
       setState(() {
         print ("hii");
      // Navigator.push(
      // context,
      // MaterialPageRoute(
      // builder: (context) {
      //     return ImageView(
      //     imageUrl: widget.imageUrl,
      //     authorId: widget.author["ownerName"],
      //     authorImage: widget.author["Avatar"],
      //     faves: widget.faves,
      //     comments: widget.comments,
       //     );
       //     },
        //    ),
         //   );
         //   }
      //       );
       //     },
       });
           },
              child: Image(
                fit: BoxFit.fill,
                image:NetworkImage(
                  widget.imageUrl,
                ),
              ),
        ),
      ),
    );
  }
}


