import 'package:flutter/material.dart';
import '../../../customeWidgets.dart';
import 'package:flutter/cupertino.dart';
import '../../../../Services/networking.dart';
import '../../../../constants.dart';
import 'dart:convert';

/// This the view a of the albums of the user it preview the alums in a scrollable view

class Albums extends StatefulWidget {
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  List<AlbumCard> albumList = [];
  List<dynamic> albums = [];

  void loadAlbumCard() async {
    NetworkHelper req = new NetworkHelper("$KBaseUrl/album");

    var res = await req.getData(true);
    print(res.statusCode);
    if (res.statusCode == 200) {
      albums = jsonDecode(res.body);
    }

    setState(() {
      albums.forEach((element) {
        print(element["title"]);
        print(element["createdAt"]);
        // print(element["photos"]);
        print(element["photos"].first["photoUrl"]);
        print(element["photos"].first["ownerId"]);

        albumList.add(AlbumCard(
            AlbumName: element["title"],
            dateCreated: element["createdAt"],
            photos: element["photos"],
            imageUrl: element["photos"].first["photoUrl"]));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadAlbumCard();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: new ListView.builder(
              itemCount: albumList.length,
              itemBuilder: (BuildContext context, int index) {
                return albumList[index];
              },
            ))
          ],
        ),
      ),
    );
  }
}

/// This is the view inside a chosen album it preview the photos
/// @AlbumName : the name of the albums
/// @dateCreated : creation date
/// @photos : list of the photos
/// @imageUrl : the path of the cover photo of the album

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
  List<AlbumPhotos> ALbumPhotosList = [];

  void LoadAlbumPhotos() {
    int counter = 0;
    print(widget.photos);
    widget.photos.forEach((element) {
      ALbumPhotosList.add(AlbumPhotos(image1: element));
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
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: new ListView.builder(
                  itemCount: ALbumPhotosList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ALbumPhotosList[index];
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The view of photo inside the album
/// @image1 : the path of the viewed photo
class AlbumPhotos extends StatefulWidget {
  AlbumPhotos({
    @required this.image1,
  });

  final Map<String, dynamic> image1;

  @override
  _AlbumPhotosState createState() => _AlbumPhotosState();
}

class _AlbumPhotosState extends State<AlbumPhotos> {
  List<String> photosRow = [];
  int counter = 0;

  Widget ImagesAvailbe() {
    if (widget.image1["photoUrl"] != '') {
      return Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Image(
                  image: NetworkImage(widget.image1["photoUrl"]),
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
