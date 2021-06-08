import 'package:flutter/material.dart';
import '../../../customeWidgets.dart';
import 'package:flutter/cupertino.dart';
import '../../../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../Services/networking.dart';
import 'dart:convert';



///This the view of the camera roll of a current user which preview his/her photos in a scrollable view.
class CameraRoll extends StatefulWidget {
  final String id = null;
  @override
  _CameraRollState createState() => _CameraRollState();
}

class _CameraRollState extends State<CameraRoll> {
  List<PhotoCard> photoList = [];

  void loadPhotoCard(List<dynamic> photos) {
    photoList.clear();
    photos.forEach((element) {
      photoList.add(PhotoCard(imageUrl: element["photoUrl"]));
    });
  }

  void getPhotos() async {
    String getPhotosRequest = (widget.id == null)
        ? "$KBaseUrl/user/photos"
        : "$KBaseUrl/people/photos/";
    NetworkHelper photoreq = new NetworkHelper(getPhotosRequest);
    var photoresp = await photoreq.getData(true);
    print(widget.id);
    print(photoresp.statusCode);
    if (photoresp.statusCode == 200) {
      setState(() {
        String data2 = photoresp.body;
        Map<String, dynamic> response2 = jsonDecode(data2);
        //print("ana response bs decoded");
        //print(response2);
        loadPhotoCard(response2['photos']);
      });
    } else {
      print(photoresp.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotos();
  }

  bool row = false;
  bool selected = false;
  bool privacy = false;
  bool share = false;
  bool album = false;
  bool delete = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[

            Expanded(
              child: new ListView.builder(
                itemCount: photoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return photoList[index];
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
