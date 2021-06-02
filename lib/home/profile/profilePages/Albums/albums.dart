import 'package:flutter/material.dart';
import '../../../customeWidgets.dart';
import 'package:flutter/cupertino.dart';
import '../../../../Services/networking.dart';
import '../../../../constants.dart';
import 'dart:convert';


class Albums extends StatefulWidget {


  
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {

  List<AlbumCard> albumList=[];
  List<dynamic> albums=[];

  void loadAlbumCard() async
  {


    NetworkHelper req = new NetworkHelper("$KBaseUrl/album");

    var res = await req.getData(true);
    print(res.statusCode);
    if (res.statusCode == 200) {
      albums = jsonDecode(res.body);
    }

    setState(() {
      albums.forEach((element)  {

        print(element["title"]);
        print(element["createdAt"]);
        // print(element["photos"]);
        print(element["photos"].first["photoUrl"]);
        print(element["photos"].first["ownerId"]);



        albumList.add(
            AlbumCard(AlbumName: element["title"], dateCreated: element["createdAt"], photos: element["photos"], imageUrl: element["photos"].first["photoUrl"])
        ) ;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // List<dynamic> albums=[
    //   {
    //     "_id": 0,
    //     "title": "SpongeBob Lovers",
    //     "description": "string",
    //     "createdAt": "24-12-2021",
    //     "updatedAt": "string",
    //     "photos": [
    //       {
    //         "photo_url":"https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
    //       }
    //       ,
    //       {
    //         "photo_url":"https://assets-global.website-files.com/6005fac27a49a9cd477afb63/60576840e7d265198541a372_bavassano_homepage_gp.jpg"
    //       }
    //     ],
    //     "coverPhoto": "Unknown Type: _id"
    //   }
    //   ,
    //   {
    //     "_id": 0,
    //     "title": "Sad",
    //     "description": "string",
    //     "createdAt": "24-12-2021",
    //     "updatedAt": "string",
    //     "photos": [
    //       {
    //         "photo_url":"https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fstartswithabang%2Ffiles%2F2017%2F07%2F1-7BMKLs6CDB75eO35-ErBpg.jpg"
    //       }
    //       ,
    //       {
    //         "photo_url":"https://static.toiimg.com/thumb/msid-31346158,width-748,height-499,resizemode=4,imgsize-114461/.jpg"
    //       }
    //     ],
    //     "coverPhoto": "Unknown Type: _id"
    //   }
    //
    // ];
    loadAlbumCard();

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
      ),
    );
  }
}

class AlbumView extends StatefulWidget {

  AlbumView({
    @required this.AlbumName,
    @required this.dateCreated,
    @required this.photos,
    @required this.imageUrl,
  });


  final String AlbumName;
  final String dateCreated;
  final List<dynamic> photos;
  final String imageUrl;

  @override
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {

  List<AlbumPhotos> ALbumPhotosList=[];
  
  void LoadAlbumPhotos()
  {
    int counter=0;
    print(widget.photos);
    widget.photos.forEach((element) {

      ALbumPhotosList.add(
        AlbumPhotos(image1: element)
      );
    });
    
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      LoadAlbumPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Column(
        children:<Widget> [
          Row(

            mainAxisAlignment: MainAxisAlignment.end,
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.only(right:8.0,top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (states) => Colors.transparent),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFF464646), width: 2),
                      ),
                    ), //MaterialProperty
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: Text(
                      "Select",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Frutiger',
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

          Expanded(
            child: Column(
              children:<Widget> [
                Expanded(child: new ListView.builder(
                  itemCount: ALbumPhotosList.length,
                  itemBuilder:(BuildContext context, int index)
                  {
                    return ALbumPhotosList[index];
                  },
                )
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class AlbumPhotos extends StatefulWidget {

  AlbumPhotos({
    @required this.image1,
  });

  final Map<String,dynamic> image1;


  @override
  _AlbumPhotosState createState() => _AlbumPhotosState();
}

class _AlbumPhotosState extends State<AlbumPhotos> {

  List<String> photosRow=[];
  int counter=0;

  Widget ImagesAvailbe()
  {
    if (widget.image1["photoUrl"]!='')
      {
            return  Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: Image(image:
                      NetworkImage(
                          widget.image1["photoUrl"]
                      ),
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
