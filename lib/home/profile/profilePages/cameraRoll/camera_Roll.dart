import 'package:flutter/material.dart';
import '../../../customeWidgets.dart';
import 'package:flutter/cupertino.dart';
import '../../../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../Services/networking.dart';
import 'dart:convert';

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
            //     ListTile(
            //       leading: Text( (selected == false) ? '' : '0 Selected',
            //   style: TextStyle(
            //     //fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //     fontFamily: 'Frutiger',
            //     fontSize: 20.0,
            //   ),
            // ),
            //         trailing: TextButton(
            //               style: ButtonStyle(
            //                 backgroundColor: MaterialStateProperty.all(kBackgroundColor),
            //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //                   RoundedRectangleBorder(
            //                     side: BorderSide(color: Colors.black, width: 2.0),
            //                   ),
            //                 ),
            //               ),
            //               onPressed: () {
            //                 setState(() {
            //                   if (selected == false) {
            //                     row = true;
            //                     selected = true;
            //                   }
            //                   else {
            //                     row = false;
            //                     selected=false;
            //                   }
            //                 });
            //               },
            //               child: Text( (selected == false) ? 'Select' : 'Done',
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.black,
            //                   fontFamily: 'Frutiger',
            //                   fontSize: 16.0,
            //                 ),
            //               ),
            //         ),
            //      ),
            Expanded(
              child: new ListView.builder(
                itemCount: photoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return photoList[index];
                },
              ),
            ),
            //
            // Visibility(
            //   visible: (row == true) ? true : false,
            //   child: Container(
            //     color: Colors.black,
            //     height: 50.0,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: <Widget>[
            //           IconButton( icon: Icon(
            //                     Icons.lock,
            //                      size: 25,
            //                      color: kBackgroundColor
            //               ),
            //             onPressed: () {
            //               setState(() {
            //                 privacy = true;
            //                 share = false;
            //                 album = false;
            //                 delete = false;
            //               });
            //             },
            //             ),
            //           IconButton( icon: Icon(
            //                 Icons.folder_open_outlined,
            //                 size: 25,
            //                 color: kBackgroundColor
            //             ),
            //             onPressed: () {
            //            setState(() {
            //              privacy = false;
            //              share = false;
            //              album = true;
            //              delete = false;
            //            });
            //             },
            //           ),
            //           IconButton( icon: Icon(
            //                 Icons.share,
            //                 size: 25,
            //                 color: kBackgroundColor
            //             ),
            //             onPressed: () {
            //               setState(() {
            //                 privacy = false;
            //                 share = true;
            //                 album = false;
            //                 delete = false;
            //               });
            //             },
            //           ),
            //           IconButton( icon: Icon(
            //          FontAwesomeIcons.trash,
            //         size: 20,
            //         color: kBackgroundColor
            //         ),
            //             onPressed: () {
            //               setState(() {
            //                 privacy = false;
            //                 share = false;
            //                 album = false;
            //                 delete = true;
            //               });
            //             },
            //           ),
            //           ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
