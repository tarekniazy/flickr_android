import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../customeWidgets.dart';





class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
 List<Map<String, dynamic>> comments;



  List<ImageCard> post=[
    ImageCard(imageUrl: "https://media.gettyimages.com/photos/giza-egypt-pyramids-in-sunset-scene-wonders-of-the-world-picture-id1085205362?s=612x612",
    authorId: "SpongeBob",
    authorImage: "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
    numberOfFaves: 1290,
    numberOfComments:1230,
    usernameTopComment: "Thomas Bvr",
    topComment: "This Pic is amazing. No Need to talk,woooooooow",
  ),
    ImageCard(imageUrl: "https://static.toiimg.com/photo/72975551.cms",
      authorId: "Baseet",
      authorImage: "https://cdn.shopify.com/s/files/1/2726/1450/products/RE_Spongebob_Patrick-fig_NYCC_2048_64e13260-ad62-46dd-a617-e6752597dc22_600x600.jpg?v=160452973033",
      numberOfFaves: 1290,
      numberOfComments:1230,
      usernameTopComment: "Angela Yu",
      topComment: "Never Mind",
    ),

    ImageCard(imageUrl: "https://images.ctfassets.net/hrltx12pl8hq/3MbF54EhWUhsXunc5Keueb/60774fbbff86e6bf6776f1e17a8016b4/04-nature_721703848.jpg?fit=fill&w=480&h=270",
      authorId: "Boo",
      authorImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTTKDd_d5wfvokkE5cdLjgMw9v5N9UNOovRg&usqp=CAU",
      numberOfFaves: 1290,
      numberOfComments:1230,
      usernameTopComment: "Sifoo",
      topComment: "Kung Foooo",
    )

  ];

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



