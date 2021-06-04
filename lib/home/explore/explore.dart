import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../customeWidgets.dart';
import '../../Services/networking.dart';
import '../../constants.dart';
import 'dart:convert';


/// @exploreImages : this is the data that is parsed into posts [ImageCard] and displayed in a form of stream

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

 List<dynamic> favedPhotos=[];
 List<String> favedIds=[];

 int isFaved=0;

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

 void getUserfavs() async{

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

/// this function is responsible for getting the photos that is faved by the current logged in user in order to be compared with the streamed photos to verify wither the user faved this already faved this photo or not

  void loadImageCard() async
  {


    NetworkHelper req = new NetworkHelper("$KBaseUrl/user/fav");

    var res = await req.getData(true);

    if (res.statusCode == 200)
      {
        setState(() {
          String data2 = res.body;
          favedPhotos = jsonDecode(data2);
        });

        favedPhotos.forEach((element) {


         setState(() {
           favedIds.add(element["_id"]);
         });


        });
      }



    print(widget.exploreImages.length);
    // print(widget.exploreImages);

    widget.exploreImages.forEach((element)  {
      isFaved=0;
      // print(element["comments"].length);

      // // print(element["photos"]);
      // print(element["photos"].first["photoUrl"]);
      // print(element["photos"].first["ownerId"]);

      // Map<String,dynamic> owner={
      //   "ownerName":element["ownerName"],
      //   "ownerUsername":element["ownerUsername"],
      //   "Avatar":element["Avatar"]
      // };
      print(element["_id"].runtimeType);

      for (int i=0;i<favedIds.length;i++)
        {
          print(element["_id"]);
          if (element["_id"] == favedIds[i])
            {
              setState(() {
                isFaved=1;
                print("already faved  "+element["_id"]+" "+isFaved.toString());
              });

            }
        }




      post.add(
          ImageCard(imageUrl:element["photoUrl"],imageId:element["_id"] ,isfaved: isFaved ,author: element["ownerId"],comments: element["comments"],faves: element["Fav"])) ;
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



