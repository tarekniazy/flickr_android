import 'package:flutter/material.dart';
import '../../../../signup/signupStyling/signup_Widgets.dart';
import '../../../customeWidgets.dart';
import 'package:flutter/cupertino.dart';
import '../../../../constants.dart';
//import '../../signup/signupStyling/signup_Widgets.dart';
class CameraRoll extends StatefulWidget {
  @override
  _CameraRollState createState() => _CameraRollState();
}

class _CameraRollState extends State<CameraRoll> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  List<PhotoCard> photoPost = [
    PhotoCard(
        imageUrl:
        "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg"),

    PhotoCard(

        imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTTKDd_d5wfvokkE5cdLjgMw9v5N9UNOovRg&usqp=CAU"),
    PhotoCard(
        imageUrl:
        "https://cdn.shopify.com/s/files/1/2726/1450/products/RE_Spongebob_Patrick-fig_NYCC_2048_64e13260-ad62-46dd-a617-e6752597dc22_600x600.jpg?v=160452973033"),

    PhotoCard(

        imageUrl:
        "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg"),

    PhotoCard(
        imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTTKDd_d5wfvokkE5cdLjgMw9v5N9UNOovRg&usqp=CAU")

  ];

  bool row = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kBackgroundColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    row = true;
                  });
                },
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Frutiger',
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            UserView(
            userBody: photoPost,
          ),
            Visibility(
              visible: (row == true) ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    // ElevatedButton.icon(
                    //     onPressed: () {
                    //       setState(() {
                    //         row = true;
                    //       });
                    //     },
                    //     icon: kSearchIcon,
                    //   label: labe,
                    //     )
                    // TextButton(
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all(kBackgroundColor),
                    //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //       RoundedRectangleBorder(
                    //         side: BorderSide(color: Colors.black, width: 2.0),
                    //       ),
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     setState(() {
                    //
                    //     });
                    //   },
                    //   child: Text(
                    //     'Select',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //       fontFamily: 'Frutiger',
                    //       fontSize: 16.0,
                    //     ),
                    //   ),
                    // ),
                    ],
              ),
            ),
          ],
        ),
        ),
    );
  }
}
