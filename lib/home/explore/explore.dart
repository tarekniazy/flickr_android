import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../customeWidgets.dart';
import '../../Services/networking.dart';
import '../../constants.dart';
import 'dart:convert';


class Explore extends StatefulWidget {
  Explore({

    @required this.exploreImages,
  });


  final  List<dynamic> exploreImages;



  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {


 List<ImageCard> post=[];

 void loadUsers(userId) async{

   NetworkHelper req = new NetworkHelper(
       "$KMockSeverBaseUrl/people/id");

   var res = await req.getData(true);

   if (res.statusCode == 200)
     {
       String data = res.body;
         print(jsonDecode(data));
     }

 }

  void loadImageCard()
  {

    Map<String,dynamic> about={
      "About": {

        "City":"blll",
        "Description":"ggggggg"

        }
      };




        widget.exploreImages.forEach((element)  {






      if (element["ownerId"]!=null)
        {
          print(element["ownerId"]);


        }

        // ImageCard imageCard= new ImageCard(imageUrl: element["photo_url"],
        //   authorId: element["photo_owner_name"],
        //   authorImage: element["avatar_owner_url"],
        //   faves:element["favs"],
        //   comments:element["comment"],
        // );
          print(post.length);
    });



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImageCard();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black87,
        child: Column(
          children:<Widget> [
            // Expanded(child: new ListView.builder(
            //   itemCount: post.length,
            //   itemBuilder:(BuildContext context, int index)
            //   {
            //     return post[index];
            //   },
            // )
            //  )
            Text("data")
          ],
        ),
        // child: post[0],

      ),
    );
  }
}



