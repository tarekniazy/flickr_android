
import 'package:flickr_android/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  ImageCard({
    @required this.imageUrl,
    @required this.authorId,
    @required this.authorImage,
    @required this.numberOfComments,
    @required this.numberOfFaves,
    @required this.topComment,
    @required this.usernameTopComment,
  });

  final String imageUrl; // image path
  final String authorId; // author name
  final String authorImage; // author profile pic
  final numberOfFaves; // number of likes
  final numberOfComments; // number of comments
  final String topComment; // top comment
  final String usernameTopComment; // name of the user who made the top comment

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
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

  var like=0;

  Icon likePressed()
  {
    if (like==1)
      {
        return  Icon(
          Icons.star,
          color: Colors.blue,
        );

      }
    else {
      return  Icon(
          Icons.star_border
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              // Navigator.pushNamed(context, 'ImageView');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ImageView(
                      imageUrl: widget.imageUrl,
                      authorId: widget.authorId,
                      authorImage: widget.authorImage,
                      numberOfFaves: widget.numberOfFaves,
                      numberOfComments: widget.numberOfComments,
                      usernameTopComment: widget.usernameTopComment,
                      topComment: widget.topComment,
                    );
                  },
                ),
              );
            });
          },
          child: Image(
            image: NetworkImage(widget.imageUrl),
          ),
        ),
        Card(
          child: ListTile(
              title: Text(
                widget.authorId,
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
                      image: NetworkImage(widget.authorImage),
                    )),
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: (){

                setState(() {

                  if (like==1)
                    {
                      like=0;
                    }
                  else
                    {
                      like=1;
                    }


                });
              },
              child: IconButton(
                icon: likePressed(),
              ),
            ),
            checkIfAvailble(widget.numberOfFaves),
            IconButton(
              icon: Icon(
                Icons.messenger_outline,
              ),
            ),
            checkIfAvailble(widget.numberOfComments),
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
              widget.usernameTopComment,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Frutiger',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.topComment,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Frutiger',
                color: Colors.black54,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ImageView extends StatefulWidget {
  ImageView({
    @required this.imageUrl,
    @required this.authorId,
    @required this.authorImage,
    @required this.numberOfComments,
    @required this.numberOfFaves,
    @required this.topComment,
    @required this.usernameTopComment,
  });

  final String imageUrl; // image path
  final String authorId; // author name
  final String authorImage; // author profile pic
  final numberOfFaves; // number of likes
  final numberOfComments; // number of comments
  final String topComment; // top comment
  final String usernameTopComment; // name of the user who made the top comment

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  Icon like = Icon(
    Icons.star_border,
    size: 25,
    color: Colors.white,
  );
  bool likePressed=false;

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
            // Container(
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //        shape: BoxShape.rectangle,
            //       image: DecorationImage(
            //         image: NetworkImage(widget.imageUrl),
            //         fit: BoxFit.fill,
            //       )
            //   ),
            // ),

            Container(
              child: Image(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.contain,
                // height: 100,
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
                      Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              onPressed: (){
                                setState(() {

                                  if (likePressed)
                                    {
                                      like = Icon(
                                          Icons.star_border,
                                        size: 25,
                                        color: Colors.white,
                                      );
                                      likePressed=false;

                                    }
                                  else
                                    {
                                      like = Icon(
                                          Icons.star,
                                        color: Colors.blue,
                                        size: 25,

                                      );

                                      likePressed=true;
                                    }



                                });
                            },

                              icon:like,

                            ),
                            IconButton(
                              icon: Icon(
                                Icons.messenger_outline,
                                size: 25,
                                color: Colors.white,
                              ),
                              onPressed: () {},
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
                                    "${widget.numberOfFaves} faves",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Frutiger',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "${widget.numberOfComments} comments",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Frutiger',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
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

class UserCard extends StatefulWidget {
  UserCard({
    @required this.authorName,
    @required this.authorImage,
    @required this.numberOfPhotos,
    @required this.numberOfFollowers,
  });

  final String authorName; // author name
  final String authorImage; // author profile pic
  final numberOfPhotos;
  final numberOfFollowers;

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool followed = false;
  String text='+ Follow';
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      tileColor: kBackgroundColor,
      child: ListTile(
        leading: Container(
 width: 50,
 decoration: BoxDecoration(
 shape: BoxShape.circle,
 image: DecorationImage(
 image: NetworkImage(widget.authorImage),
 )
    ),
 ),
          title: Text(widget.authorName,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Frutiger',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          ),
          subtitle: Text(widget.numberOfPhotos + ' photos — ' + widget.numberOfFollowers + ' followers'),
          trailing: Container(
            width: (followed == true) ? 35.0 : 80.0,
            child: TextButton (

      style: ButtonStyle(
      backgroundColor:
      MaterialStateProperty.all(kBackgroundColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
    ),
    onPressed: () {
    setState(() {
      if (followed == false)
        {
            text = '✔';
            followed = true;
        }
      else
        {
            text = '+ Follow';
            followed = false;
        }
    });
    },

    child: Text(text,
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


class GroupCard extends StatefulWidget {
  GroupCard({
    @required this.authorName,
    @required this.authorImage,
    @required this.numberOfPhotos,
    @required this.numberOfMembers,
  });

  final String authorName; // author name
  final String authorImage; // author profile pic
  final numberOfPhotos;
  final numberOfMembers;


  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  bool followed = false;
  String text='+ Follow';
 // bool lessPadding=false;

  // void checkPadding()  {
  //   if (widget.lengthOfName > 30) {
  //     setState(() {
  //       lessPadding = true;
  //       print (widget.lengthOfName + " ana akbar mn 30 ");
  //     });
  //
  //   }
  //   else
  //   {
  //     setState(() {
  //       lessPadding = false;
  //       print (widget.lengthOfName + " ana asghar mn 30 ");
  //     });
  //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(12.0,11.0,12.0,6.0),
      height: 105,
      child : Row(
        children: <Widget> [
        Container(
            height: 78,
            width: 105,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: NetworkImage(widget.authorImage),
                )
            ),
          ),
          SizedBox(
            width: 1.7,
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
            children: <Widget> [

              Container(
                width: 250,
                child: Text(widget.authorName,
                  maxLines: 2,
                  textAlign: TextAlign.justify,

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
                padding: const EdgeInsets.only(top:15.0),
                child: Text(widget.numberOfMembers + ' members',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Frutiger',
                  color: Colors.grey[700],
                ),
                ),
              ),

                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(widget.numberOfPhotos + ' photos',
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
