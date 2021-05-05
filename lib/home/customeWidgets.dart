
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Services/networking.dart';

class ImageCard extends StatefulWidget {
  ImageCard({
    @required this.imageUrl,
    @required this.authorId,
    @required this.authorImage,
    @required this.comments,
    @required this.faves,
  });

  final  String imageUrl; // image path
  final  String authorId; // author name
  final  String authorImage; // author profile pic
  final  List< dynamic>  comments;
  final  List< dynamic> faves;



  // final numberOfFaves; // number of likes
  // final numberOfComments; // number of comments
  // final String topComment; // top comment
  // final String usernameTopComment; // name of the user who made the top comment

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
                        authorId: widget.authorId,
                        authorImage: widget.authorImage,
                        faves: widget.faves,
                        comments: widget.comments,
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
                onTap: () async {


                  Map<String, dynamic> Body = {
                    "photo_id": "1"
                  };


                  if (like==0)
                  {
                    NetworkHelper req = new NetworkHelper(
                        "https://4ed699e3-6db5-42c4-9cb2-0aca2896efa9.mock.pstmn.io/v3/fave?id =23");

                    var res = await req.postData(Body);

                    if (res.statusCode == 200) {

                      String data=res.body;
                      var response= jsonDecode(data);
                      print(response["message"]);
                    } else {
                      print(res.statusCode);
                    };
                  }


                  setState(()   {

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
              checkIfAvailble(widget.faves.length),
              IconButton(
                icon: Icon(
                  Icons.messenger_outline,
                  color: Colors.black45,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CommentView(authorId: widget.authorId,faves: widget.faves, comments: widget.comments);}));
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

              widget.comments.last["owner_name"],
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Frutiger',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: GestureDetector(
                child: Text(
                  widget.comments.last["comment"],
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Frutiger',
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: (){
                  setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CommentView(authorId: widget.authorId, faves: widget.faves, comments: widget.comments);}));
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
            child: Container(
              color:Colors.black ,
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
  });

  final  String imageUrl; // image path
  final  String authorId; // author name
  final  String authorImage; // author profile pic
  final  List< dynamic>  comments;
  final  List< dynamic>  faves;

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {





  Icon like = Icon(
    Icons.star_border,
    size: 25,
    color: Color(0xFFFFFFFF),
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
                      Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () async {

                                Map<String, dynamic> Body = {
                                  "photo_id": "1"
                                };


                                if (likePressed==false)
                                {
                                  NetworkHelper req = new NetworkHelper(
                                      "https://4ed699e3-6db5-42c4-9cb2-0aca2896efa9.mock.pstmn.io/v3/fave?id =23");

                                  var res = await req.postData(Body);

                                  if (res.statusCode == 200) {

                                    String data=res.body;
                                    var response= jsonDecode(data);
                                    print(response["message"]);
                                  } else {
                                    print(res.statusCode);
                                  };
                                }

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
                              onPressed: () {
                                setState(() {

                                       Navigator.push(context, MaterialPageRoute(builder: (context){
                                         return CommentView(authorId: widget.authorId, faves: widget.faves, comments: widget.comments);}));

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
                                    onTap: (){
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

  final  String authorId; // author name
  final  List< dynamic>  comments;
  final  List< dynamic>  faves;
  // var commentClicked;


  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {




  List<CommentCard> commentBody=[];

  List<UserCard> userBody=[];

   TextEditingController _controller=new TextEditingController();

  var commentViewed=1;
  var favedViewed=0;


  Widget commentOrFavs()
  {
    if (commentViewed==1)
    {
       return CommentSection(comments: widget.comments, commentBody: commentBody,authorName: widget.authorId,favs: widget.faves,);
    }
    else if (commentViewed==0)
    {
       return UserView(userBody: userBody,);

    }

  }

  void loadComments()
  {


    widget.comments.forEach((element) {

        {
          commentBody.add(CommentCard(authorId: element["owner_name"],
          authorImage: element[ "avater_owner_url"],
          comment: element[ "comment"]));
          }

    });

  }

  void loadFavs()
  {


    widget.faves.forEach((element) {

      {
        userBody.add(UserCard(authorName: element["owner_name"], authorImage: element["avater_owner_url"], numberOfPhotos: element["number_of_photos"], numberOfFollowers: element["number_of_followers"],favs: widget.faves));
      }

    });

  }

  TextStyle viewed (var check)
  {
    if (check==1)
    {
      return TextStyle(

        shadows: [
          Shadow(
              color: Colors.black,
              offset: Offset(0, -10))
        ],

        decorationThickness: 3,
        decoration: TextDecoration.underline,
        decorationColor: Colors.black,
        fontSize: 18,
        fontFamily: 'Frutiger',
        color: Colors.transparent,
        fontWeight: FontWeight.bold,
      );
    }
    else
    {
      return  TextStyle(
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
              widget.authorId+"'s photo",
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
            children:<Widget> [

              Container(
                height: 70,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                   GestureDetector(
                      onTap: (){
                        setState(() {
                          favedViewed=1;
                          commentViewed=0;
                        });
                      },
                      child: Text(
                        '${userBody.length}'+' faves',
                        style:viewed(favedViewed),
                      ),
                    ),

                 GestureDetector(
                      onTap: (){
                        setState(() {
                          favedViewed=0;
                          commentViewed=1;
                        });
                      },
                      child: Text(
                          '${commentBody.length}'+' comments',
                          style:viewed(commentViewed)
                      ),
                    ),

                  ],
                ),
              ),

           commentOrFavs(),
       // CommentSection(comments: widget.comments, commentBody: commentBody,authorName: widget.authorId,favs: widget.faves,),
       //       UserView(userBody: userBody,favs: widget.faves),


            ],
          ),
        )
    );
  }
}


class CommentCard extends StatefulWidget {

  CommentCard({

    @required this.authorId,
    @required this.authorImage,
    @required this.comment,

  });


  final String authorId; // author name
  final String authorImage; // author profile pic
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
        padding: const EdgeInsets.only(bottom:20.0,top: 20),
        child: ListTile(
          leading: Container(
            width:50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.authorImage),
                )),
          ) ,
          title:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                    widget.authorId,
                    style:TextStyle(
                      fontSize: 16,
                      fontFamily: 'Frutiger',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                ),


                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0,top: 8),
                    child: Text(
                             widget.comment,
                           style:TextStyle(
                                fontSize: 14,
                                 fontFamily: 'Frutiger',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                    ),
                               ),
                  ),

                Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: Text(
                    "Reply",
                    style:TextStyle(
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
  UserCard({
    @required this.authorName,
    @required this.authorImage,
    @required this.numberOfPhotos,
    @required this.numberOfFollowers,
    @required this.favs
  });

  final String authorName; // author name
  final String authorImage; // author profile pic
  final numberOfPhotos;
  final numberOfFollowers;
  final   List<dynamic> favs;


  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool followed = false;
  String text='+ Follow';
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
              MaterialStateProperty.all(Colors.grey[300]),
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
                  if (widget.favs!=null){
                    widget.favs.forEach((element) {

                      if (element["owner_name"]=="Garyyy")
                      {
                        var count= int.parse(element["number_of_followers"]);
                        count++;
                        element["number_of_followers"]='$count';
                      }
                    });
                  }
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

class UserView extends StatefulWidget {

  UserView({
    @required this.userBody,
  });



  final   List<dynamic> userBody;

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children:[ Expanded(child: new ListView.builder(
            itemCount: widget.userBody.length,
            itemBuilder:(BuildContext context, int index)
            {
              return widget.userBody[index];
            },
          )
          ),
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


  final  List< dynamic>  comments;
  final  List<CommentCard>  commentBody;
  final  List< dynamic>  favs;
  final String authorName;



  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {

  TextEditingController _controller=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return     Expanded(
      child: Container(
        child: Column(children: [
          Expanded(child: new ListView.builder(
            itemCount: widget.commentBody.length,
            itemBuilder:(BuildContext context, int index)
            {
              return widget.commentBody[index];
            },
          )
          ),

          Align(
            alignment:Alignment.bottomCenter,
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



                  onPressed: (){
                    setState(() {

                      print(_controller.text);

                      widget.commentBody.add(CommentCard(authorId: "Tarek", authorImage: "https://digestfromexperts.com/wp-content/uploads/2020/01/How-old-is-Squidward-in-Spongebob-Squarepants.jpg", comment: _controller.text));
                      widget.comments.add({
                        "id": 0,
                        "comment":  _controller.text,
                        "photo_id": 0,
                        "comment_owner_id": 0,
                        "owner_name": "Tarek",
                        "avater_owner_url": "https://digestfromexperts.com/wp-content/uploads/2020/01/How-old-is-Squidward-in-Spongebob-Squarepants.jpg"
                      });

                      print(widget.comments);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => CommentView(authorId: widget.authorName,comments: widget.comments,faves: widget.favs,)));

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
                    style:TextStyle(
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

        ],),
      ),
    )    ;

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


