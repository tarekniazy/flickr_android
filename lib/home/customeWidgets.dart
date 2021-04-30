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
            IconButton(
              icon: Icon(
                Icons.star_border,
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
            //
            // Expanded(
            //    child: Align(
            //      alignment: FractionalOffset.bottomCenter,
            //      child: Divider(
            //       thickness: 1,
            //       color: Colors.white,
            //   ),
            //    ),
            // ),

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
                              icon: Icon(
                                Icons.star_border,
                                size: 25,
                                color: Colors.white,
                              ),
                              onPressed: () {},
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
                // child:Row(
                //         children:<Widget> [

                //

                //

                //
                //         ],
                //       ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
