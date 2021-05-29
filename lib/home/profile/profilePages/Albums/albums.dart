import 'package:flutter/material.dart';
import '../../../customeWidgets.dart';
import 'package:flutter/cupertino.dart';




class Albums extends StatefulWidget {

  // Albums({
  //
  //   @required this.albumList,
  // });
  //
  // final  List<dynamic> albumList;
  
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {

  List<AlbumCard> albumList=[];

  void loadAlbumCard(List<dynamic> albums)
  {


    albums.forEach((element)  {

      print(element["title"]);
      print(element["createdAt"]);
      print(element["photos"].length.toString());
      print(element["photos"].first["photo_url"]);


      albumList.add(
        AlbumCard(AlbumName: element["title"], dateCreated: element["createdAt"], numberOfPhotos: element["photos"].length.toString(), imageUrl: element["photos"].first["photo_url"])
      ) ;
    });


    print(albumList.length);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<dynamic> albums=[
      {
        "_id": 0,
        "title": "SpongeBob Lovers",
        "description": "string",
        "createdAt": "24-12-2021",
        "updatedAt": "string",
        "photos": [
          {
            "photo_url":"https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
          }
          ,
          {
            "photo_url":"https://assets-global.website-files.com/6005fac27a49a9cd477afb63/60576840e7d265198541a372_bavassano_homepage_gp.jpg"
          }
        ],
        "coverPhoto": "Unknown Type: _id"
      }
      ,
      {
        "_id": 0,
        "title": "Sad",
        "description": "string",
        "createdAt": "24-12-2021",
        "updatedAt": "string",
        "photos": [
          {
            "photo_url":"https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fstartswithabang%2Ffiles%2F2017%2F07%2F1-7BMKLs6CDB75eO35-ErBpg.jpg"
          }
          ,
          {
            "photo_url":"https://static.toiimg.com/thumb/msid-31346158,width-748,height-499,resizemode=4,imgsize-114461/.jpg"
          }
        ],
        "coverPhoto": "Unknown Type: _id"
      }

    ];

    loadAlbumCard(albums);


  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(

        child: Column(
          children:<Widget> [
            Expanded(child: new ListView.builder(
              itemCount: albumList.length,
              itemBuilder:(BuildContext context, int index)
              {
                return albumList[index];
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

// Padding(
// padding: const EdgeInsets.all(8.0),
// child: AlbumCard(AlbumName: 'SpongeBob Lovers', dateCreated: '24 feb 2021', numberOfPhotos: '25', imageUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fstartswithabang%2Ffiles%2F2017%2F07%2F1-7BMKLs6CDB75eO35-ErBpg.jpg"),
// );