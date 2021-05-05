import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../customeWidgets.dart';





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

  void loadImageCard()
  {




    widget.exploreImages.forEach((element)  {


        post.add(ImageCard(imageUrl: element["photo_url"],
          authorId: element["photo_owner_name"],
          authorImage: element["avatar_owner_url"],
          faves:element["favs"],
          comments:element["comment"],


        )) ;

        print(element["photo_url"]);

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
            Expanded(child: new ListView.builder(
              itemCount: post.length,
              itemBuilder:(BuildContext context, int index)
              {
                return post[index];
              },
            )
             )
          ],
        ),
        // child: post[0],

      ),
    );
  }
}



