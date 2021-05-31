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

   // NetworkHelper req = new NetworkHelper(
   //     "$KMockSeverBaseUrl/people/id");
   //
   // var res = await req.getData(true);
   //
   // if (res.statusCode == 200)
   //   {
   //     String data = res.body;
   //       print(jsonDecode(data));
   //   }

 }

  void loadImageCard()
  {





    // print(widget.exploreImages);

    widget.exploreImages.forEach((element)  {

      // print(element["title"]);

      // // print(element["photos"]);
      // print(element["photos"].first["photoUrl"]);
      // print(element["photos"].first["ownerId"]);

      Map<String,dynamic> owner={
        "ownerName":element["ownerName"],
        "ownerUsername":element["ownerUsername"],
        "Avatar":element["Avatar"]
      };
      print(owner);



      post.add(
          ImageCard(imageUrl:element["photoUrl"] ,author: owner,comments: element["comment"],faves: element["fav"])) ;
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
            Expanded(child: new ListView.builder(
              itemCount: post.length,
              itemBuilder:(BuildContext context, int index)
              {
                return post[index];
              },
            )
             )
            // Text("data")
          ],
        ),
        // child: post[0],

      ),
    );
  }
}



