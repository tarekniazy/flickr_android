import 'dart:convert';
import 'dart:io';
import 'package:flickr_android/home/profile/profileStyling/profile_Widgets.dart';
import 'package:flickr_android/home/profile/profile_screen.dart';

import '../constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Services/networking.dart';
import 'package:flickr_android/home/profile/otherProfiles_screen.dart';
import 'profile/profilePages/Albums/albums.dart';

/// Class ImageCard that draws [ImageView] and [Card] with the passed arguments
/// ...
/// see [Explore] for an implementation example of this class
class ImageCard extends StatefulWidget {
  /// Requires [imageUrl]
  /// Requires [author]
  /// Requires [comments]
  /// Requires [faves]
  /// Requires [imageId]
  /// Requires [isfaved]
  ImageCard({
    @required this.imageUrl,
    @required this.author,
    @required this.comments,
    @required this.faves,
    @required this.imageId,
    @required this.isfaved,
  });

  final String imageUrl; // image path
  final Map<String, dynamic> author; // author name
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
  Icon fav = Icon(Icons.star_border);

  List<dynamic> favedList = [];

  int viewfaved = 0;

  /// this function is responsible for getting a user by ID in order to get his/her following status to the current user
  void getUsersId() async {
    String _id;

    widget.faves.forEach((element) async {
      {
        _id = element["UserName"];

        NetworkHelper req2 = new NetworkHelper("$KBaseUrl/people/" + _id);
        var res2 = await req2.getData(true);

        if (res2.statusCode == 200) {
          print(res2.statusCode);
          print(jsonDecode(res2.body)["_id"]);
          print("isfollowed");
          print(jsonDecode(res2.body)["Follow"]);

          element["_id"] = jsonDecode(res2.body)["_id"];
          element["isfollowed"] = jsonDecode(res2.body)["Follow"];
        }

        print(element);
      }
    });
  }

  /// This function checks the [number] passed to it, returns an [Text] widget
  /// if the number is greater than 0 it returns a customized Text widget, else it returns an empty Text widgt
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

  var like = 1;

  /// This functions returns an [Icon] widget
  /// checks if the a like was pressed and accordingly returns a suitable icon (e.g. filled with blue color if liked)
  Icon likePressed() {
// setState(() {
    if (widget.isfaved == 1 || like == 0) {
      like = 1;
      return Icon(
        Icons.star,
        color: Colors.blue,
      );
    } else {
      return Icon(
        Icons.star_border,
      );
    }
// });
  }

  /// This functions returns a [String] widget
  /// checks if the comments isn't empty and returns the last comment as a Text widget if so, else returns empty Text
  String ifLastComment() {
    if (widget.comments.length != 0) {
      LastUser = widget.comments.last["user"]["Fname"];
      return widget.comments.last["comment"];
    } else {
      LastUser = " ";
      return " ";
    }
  }

  /// This functions returns a [String] widget
  /// checks if the comments isn't empty and returns the name of the user having the last comment as a Text widget if so, else returns empty Text
  String ifLastUserComment() {
    if (widget.comments.length != 0) {
      return widget.comments.last["user"]["Fname"];
    } else {
      return " ";
    }
  }

  @override
  void initState() {
    super.initState();
    getUsersId();
  }

  /// This widget is responsible for building the an [ImageView] and [Card] instances for the [ImageCard]
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
                  if (widget.isfaved == 1 || like == 0) {
                    print("faaaaaaaaaaaaaaaved");

                    print(widget.imageId.runtimeType);

                    NetworkHelper req =
                        new NetworkHelper("$KBaseUrl/favs/" + widget.imageId);

                    var res = await req.deleteData();

                    print(res.statusCode);

                    if (res.statusCode == 200) {
                      String data = res.body;
                      var response = jsonDecode(data);
                      print(response["message"]);
                    }
                    setState(() {
                      like = 1;
                    });
                  } else {
                    Map<String, dynamic> Body = {"photo_id": widget.imageId};

                    NetworkHelper req = new NetworkHelper("$KBaseUrl/favs");

                    setState(() {
                      like = 0;
                    });

                    var res = await req.postData(Body, true);

                    if (res.statusCode == 200) {
                      String data = res.body;
                      var response = jsonDecode(data);
                      print(response["message"]);
                    } else {
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
                  icon: likePressed(),
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
                        authorId: widget.author["Fname"],
                        faves: widget.faves,
                        comments: widget.comments,
                        imageId: widget.imageId,
                      );
                    }));
                  });
                },
              ),
              checkIfAvailble(widget.comments.length),
              // IconButton(
              //   icon: Icon(
              //     Icons.share,
              //   ),
              // ),
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
                        authorId: widget.author["Fname"],
                        faves: widget.faves,
                        comments: widget.comments,
                        imageId: widget.imageId,
                      );
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

/// Class ImageView creates an instance of the image posts that are found in [Explore]
class ImageView extends StatefulWidget {
  /// Requires [imageUrl]
  /// Requires [authorId]
  /// Requires [authorImage]
  /// Requires [comments]
  /// Requires [faves]
  /// Requires [imageId]
  /// Requires [isfaved]
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
  Icon likePressed() {
    if (widget.isfaved == 1) {
      return Icon(
        Icons.star,
        color: Colors.blue,
      );
    } else {
      return Icon(
        Icons.star_border,
        color: Colors.white,
      );
    }
  }

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
            Expanded(
              child: Image(
                image: NetworkImage(widget.imageUrl),
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
                            if (widget.isfaved == 1) {
                              print("faaaaaaaaaaaaaaaved");
                            } else {
                              Map<String, dynamic> Body = {
                                "photo_id": widget.imageId
                              };

                              NetworkHelper req =
                                  new NetworkHelper("$KBaseUrl/favs");

                              var res = await req.postData(Body, true);

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
                                  comments: widget.comments,
                                  imageId: widget.imageId,
                                );
                              }));
                            });
                          },
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

/// Class CommentView creates an instance of the comment sections posts that are found in [Explore]
class CommentView extends StatefulWidget {
  /// Requires [authorId]
  /// Requires [comments]
  /// Requires [faves]
  /// Requires [imageId]
  CommentView(
      {@required this.authorId,
      @required this.comments,
      @required this.faves,
      @required this.imageId});

  final String authorId; // author name
  final List<dynamic> comments;
  final List<dynamic> faves;
  final imageId;

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  List<CommentCard> commentBody = [];

  List<UserCard> userBody = [];

  TextEditingController _controller = new TextEditingController();

  var commentViewed = 1;
  var favedViewed = 0;

  /// This function checks the if the view is a like or comment view and returns the corresponding widget
  Widget commentOrFavs() {
    if (commentViewed == 1) {
      return CommentSection(
        comments: widget.comments,
        commentBody: commentBody,
        authorName: widget.authorId,
        favs: widget.faves,
        imageId: widget.imageId,
      );
    } else if (commentViewed == 0) {
      return UserView(
        userBody: userBody,
      );
    }
  }

  /// this function calls [CommentCard] and creates instances of it according to the comments list
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

  /// this function calls [UserCard] and creates instances of it according to the favorite list
  void loadFavs() {
    setState(() {
      widget.faves.forEach((element) async {
        {
          userBody.add(UserCard(
            authorName: element["Fname"],
            authorImage: element["Avatar"],
            numberOfPhotos: element["numPhotos"],
            numberOfFollowers: element["numFollowing"],
            favs: widget.faves,
            peopleID: element["_id"],
            isFollowed: element["isfollowed"],
          ));
        }
      });
    });
  }

  /// this function checks a variable [check] passed to it and returns a suitable [TextStyle] to show if it was viewed or not
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

/// Class CommentCard that upon calling creates an instance for a comment card containing the comment and the comment's user image, called in [loadComments]
class CommentCard extends StatefulWidget {
  /// Requires [authorId]
  /// Requires [authorImage]
  /// Requires [comment]
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
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 8.0),
              //   child: Text(
              //     "Reply",
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontFamily: 'Frutiger',
              //       color: Colors.black54,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Class UserCard that upon calling creates an instance for a user card containing his/her info, called in [loadFavs]
class UserCard extends StatefulWidget {
  /// Requires [authorName]
  /// Requires [numberOfPhotos]
  /// Requires [authorImage]
  /// Requires [numberOfFollowers]
  /// Requires [favs]
  /// Requires [peopleID]
  /// Requires [isFollowed]
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
        onTap: () {
          if (widget.peopleID != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OhterProfile(email: widget.peopleID);
            }));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Profile();
            }));
          }
        },
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
        subtitle: Text('${widget.numberOfPhotos ?? 0}' +
            ' photos — ' +
            '${widget.numberOfFollowers ?? 0}' +
            ' followers'),
        trailing: Container(
          width: (textToggle == false)
              ? ((widget.isFollowed == true) ? 35.0 : 80.0)
              : ((followed == true) ? 35.0 : 80.0),
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
                if (peopleresp.statusCode == 200) {
                  setState(() {
                    text = '✔';
                    followed = true;
                    textToggle = true;
                  });
                }
              } else {
                NetworkHelper req = new NetworkHelper(
                    "$KBaseUrl/user/unfollow/" + widget.peopleID);
                var peopleresp = await req.deleteData();
                print(peopleresp.statusCode);
                if (peopleresp.statusCode == 200) {
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
              (textToggle == false)
                  ? ((widget.isFollowed == false) ? '+ Follow' : '✔')
                  : text,
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

/// Class UserView which contains a list of users, called in [commentOrFavs]
class UserView extends StatefulWidget {
  /// Requires [userBody] type dynamic [List]
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

/// Class CommentSection which contains a list of users comments and its corresponding info, called in [commentOrFavs]
class CommentSection extends StatefulWidget {
  /// Requires [authorName] type String
  /// Requires [commentBody] type [List] <[CommentCard]>
  /// Requires [comments] type [List] <[dynamic]>
  /// Requires [favs] type [List] <[dynamic]>
  /// Requires [imageId] final
  CommentSection({
    @required this.comments,
    @required this.commentBody,
    @required this.authorName,
    @required this.favs,
    @required this.imageId,
  });

  final List<dynamic> comments;
  final List<CommentCard> commentBody;
  final List<dynamic> favs;
  final String authorName;
  final imageId;

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
      followingCount = json['Following'].length;
      followersCount = json['Followers'].length;
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
                    onPressed: () async {
                      print(widget.imageId);
                      NetworkHelper req = new NetworkHelper("$KBaseUrl" +
                          "/photo/" +
                          widget.imageId +
                          "/comments");

                      Map<String, dynamic> comment = {
                        "comment": _controller.text
                      };

                      var res = await req.postData(comment, true);

                      print(res.statusCode);

                      print(res.body);

                      if (res.statusCode == 201) {
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
                                  builder: (BuildContext context) =>
                                      CommentView(
                                        authorId: widget.authorName,
                                        comments: widget.comments,
                                        faves: widget.favs,
                                        imageId: widget.imageId,
                                      )));

                          _controller.clear();
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        });
                      }
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

/// Class GroupCard which contains a group's info
class GroupCard extends StatefulWidget {
  /// Requires [authorName] type String
  /// Requires [authorImage] type String
  /// Requires [group_id] type String
  /// Requires [numberOfPhotos] final
  /// Requires [numberOfMembers] final
  GroupCard({
    @required this.authorName,
    @required this.authorImage,
    @required this.numberOfPhotos,
    @required this.numberOfMembers,
    @required this.group_id,
  });

  final String authorName; // author name
  final String authorImage; // author home.profile pic
  final numberOfPhotos;
  final numberOfMembers;
  final String group_id;

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  bool followed = false;
  String text = '+ Follow';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return GroupView(
            group_id: widget.group_id,
          );
        }));
      },
      child: Container(
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
      ),
    );
  }
}

/// Class AlbumCard which contains an albums's info
class AlbumCard extends StatefulWidget {
  /// Requires [AlbumName] type String
  /// Requires [dateCreated] type String
  /// Requires [imageUrl] type String
  /// Requires [photos] type [List] <dynamic>
  /// Requires [user] type [Map] <String, dynamic>
  AlbumCard({
    @required this.AlbumName,
    @required this.dateCreated,
    @required this.photos,
    @required this.imageUrl,
    @required this.user,
  });

  final String AlbumName;
  final String dateCreated;
  final List<dynamic> photos;
  final String imageUrl;
  final Map<String, dynamic> user;

  @override
  _AlbumCardState createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
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
            children: <Widget>[
              Image(
                width: 100,
                height: 100,
                fit: BoxFit.fill,
                image: NetworkImage(
                  widget.imageUrl,
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
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
                          children: <Widget>[
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
                                '${widget.photos.length}' + ' photos',
                                style: TextStyle(
                                  fontFamily: 'Frutiger',
                                  color: Color(0xFF8F8F8F),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}

/// Class LoadingScreen which is called before viewing profile picture in order to issue a get rquest for the profiles info
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
            // firstName: firstName,
            // lastName: lastName,
            // avatarUrl: avatarUrl,
            // coverUrl: coverUrl,
            // email: email,
            // description: description,
            // occupation: occupation,
            // currentCity: currentCity,
            // homeTown: homeTown,
            // photosCount: photosCount,
            // followersCount: followersCount,
            // followingCount: followingCount,
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
    return Scaffold();
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
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
      child: Container(
        height: 150,
        color: kBackgroundColor,
        child: GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(
              widget.imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}

/// Class GroupView which changes a group's interface view according the passed [group_id] and the status of the user's joining
class GroupView extends StatefulWidget {
  /// Requires [group_id] type String
  GroupView({
    @required this.group_id,
  });

  final String group_id;

  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  List<dynamic> members;
  List<dynamic> photos;
  List<GroupPhotos> groupPhotos = [];
  String groupName = " ";
  int countMembers = 0;
  String role;
  Text action;

  void ifJoined() {
    if (role == null) {
      setState(() {
        action = Text(
          "+ Join",
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Frutiger',
            color: Color(0xFF464646),
            fontWeight: FontWeight.bold,
          ),
        );
      });
    }

    if (role == "member") {
      print("I am member");
      setState(() {
        action = Text(
          "Leave",
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Frutiger',
            color: Color(0xFF464646),
            fontWeight: FontWeight.bold,
          ),
        );
      });
    }
  }

  void LoadGroup() async {
    NetworkHelper req =
        new NetworkHelper("$KBaseUrl" + "/group/" + widget.group_id);

    var res = await req.getData(true);

    print(res.statusCode);

    if (res.statusCode == 200) {
      setState(() {
        countMembers = jsonDecode(res.body)["count_members"];
        print(countMembers);
        groupName = jsonDecode(res.body)["name"];
        print(groupName);
        role = jsonDecode(res.body)["role"];
      });
    }
    ifJoined();

    print("role....is " + role);
  }

  void LoadGroupPhotos() async {
    NetworkHelper req =
        new NetworkHelper("$KBaseUrl" + "/group/photos/" + widget.group_id);

    var res = await req.getData(true);

    print(res.statusCode);

    if (res.statusCode == 200) {
      setState(() {
        photos = jsonDecode(res.body);

        photos.forEach((element) {
          groupPhotos.add(GroupPhotos(image1: element));
        });

        print("the length equallllll     " + '${groupPhotos.length}');
      });
    }

    print(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setState(() {
    //
    //   action=Text(
    //     "+ Join",
    //     style: TextStyle(
    //       fontSize: 15,
    //       fontFamily: 'Frutiger',
    //       color: Color(0xFF464646),
    //       fontWeight: FontWeight.bold,
    //     ),
    //   );
    //
    //
    // });

    LoadGroup();
    LoadGroupPhotos();
    ifJoined();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: DefaultTabController(
        length: 1, // This is the number of tabs.
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
                      ElevatedButton(
                        onPressed: () async {
                          NetworkHelper req = new NetworkHelper("$KBaseUrl" +
                              "/group/" +
                              widget.group_id +
                              "/join");

                          var res = await req.postData({}, true);

                          print(res.statusCode);

                          if (res.statusCode == 200) {
                            setState(() {
                              action = Text(
                                "Leave",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Frutiger',
                                  color: Color(0xFF464646),
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            });
                          } else {
                            if (res.statusCode == 500) {
                              NetworkHelper req = new NetworkHelper(
                                  "$KBaseUrl" +
                                      "/group/" +
                                      widget.group_id +
                                      "/leave");

                              var res = await req.deleteData();

                              setState(() {
                                action = Text(
                                  "+ Join",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Frutiger',
                                    color: Color(0xFF464646),
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              });

                              print(res.statusCode);
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) => Colors.transparent),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color(0xFF464646), width: 2),
                            ),
                          ), //MaterialProperty
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: action,
                        ),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        padding: EdgeInsets.only(bottom: 42.0),
                        child: FittedBox(
                          child: Image.network(
                            "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
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
                                    // PopupMenuItem(
                                    //   child: Text(
                                    //           photosCount.toString() +
                                    //           ' of 1000 photos',
                                    //       textAlign: TextAlign.center),
                                    // ),
                                    //      const PopupMenuDivider(),
                                    // PopupMenuItem(
                                    //   child: ListTile(
                                    //     onTap: () async {
                                    //       var status =
                                    //       await Permission.camera.status;
                                    //       // if (status.isGranted) {
                                    //       //   Navigator.push(context,
                                    //       //       MaterialPageRoute(
                                    //       //           builder: (context) {
                                    //       //     return CameraApp();
                                    //       //   }));
                                    //       // }
                                    //       Map<Permission, PermissionStatus>
                                    //       statuses = await [
                                    //         // Permission.photos,
                                    //         Permission.camera,
                                    //       ].request();
                                    //       print(statuses[Permission.camera]);
                                    //     },
                                    //     title: Text('Edit Profile Photo',
                                    //         textAlign: TextAlign.center),
                                    //   ),
                                    // ),
                                    //    const PopupMenuDivider(),
                                    //     PopupMenuItem(
                                    //       child: ListTile(
                                    //         onTap: () {
                                    //           print(email);
                                    //         },
                                    //         title: Text('Edit Cover Photo',
                                    //             textAlign: TextAlign.center),
                                    //       ),
                                    //     ),
                                  ],
                                ),
                                backgroundImage: NetworkImage(
                                    "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg"),
                                radius: 20.0,
                              ),
                              Text(
                                groupName,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.grey[800]),
                              ),
                              Row(
                                children: <Widget>[
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       getUserFollowers();
                                  //     });
                                  //     print(usersListFollowers.length);
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) {
                                  //           return Folllwers_Following(
                                  //             peopleType: "Followers",
                                  //             people: usersListFollowers,
                                  //           );
                                  //         },
                                  //       ),
                                  //     );
                                  //   },
                                  //   child:
                                  Text(
                                    '${countMembers}' + ' Members',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey[800]),
                                  ),
                                  // ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  // GestureDetector(
                                  //   onTap: () async {
                                  //     setState(() {
                                  //       getUserFollowing();
                                  //     });
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) {
                                  //           return Folllwers_Following(
                                  //             peopleType: "Following",
                                  //             people: usersListFollowing,
                                  //           );
                                  //         },
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: Text(
                                  //     'following ' +
                                  //         followingCount.toString(),
                                  //     style: TextStyle(
                                  //         fontSize: 10.0,
                                  //         color: Colors.grey[800]),
                                  //   ),
                                  // )
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
                          'Photos',
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
                Scaffold(
                  backgroundColor: Color(0xFFF2F2F2),
                  body: Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: new ListView.builder(
                              itemCount: groupPhotos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return groupPhotos[index];
                              },
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

/// Class GroupPhotos which changes a group's photo interface view according the passed [image1] and the status of the user's joining
class GroupPhotos extends StatefulWidget {
  GroupPhotos({
    @required this.image1,
  });

  final Map<String, dynamic> image1;

  @override
  _GroupPhotosState createState() => _GroupPhotosState();
}

class _GroupPhotosState extends State<GroupPhotos> {
  List<String> photosRow = [];
  int counter = 0;

  Widget ImagesAvailbe() {
    if (widget.image1["photoUrl"] != '') {
      return Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Image(
                  image: NetworkImage(widget.image1["photoUrl"]),
                ),
              ),
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ImagesAvailbe();
  }
}
