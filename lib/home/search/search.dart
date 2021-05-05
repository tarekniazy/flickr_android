import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../signup/signupStyling/signup_Widgets.dart';
import '../../home/customeWidgets.dart';
import '../customeWidgets.dart';
import '../../constants.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<UserCard> userPost=[
    UserCard (
      authorName: "SpongeBob",
      authorImage: "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
      numberOfPhotos: '1290',
      numberOfFollowers:'1.2K',
    ),

    UserCard(
      authorName: "Baseet",
      authorImage: "https://cdn.shopify.com/s/files/1/2726/1450/products/RE_Spongebob_Patrick-fig_NYCC_2048_64e13260-ad62-46dd-a617-e6752597dc22_600x600.jpg?v=160452973033",
      numberOfPhotos: '90',
      numberOfFollowers:'3.4K',
    ),

    UserCard(
      authorName: "Boo",
      authorImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTTKDd_d5wfvokkE5cdLjgMw9v5N9UNOovRg&usqp=CAU",
      numberOfPhotos: '120',
      numberOfFollowers:'349',
    )

  ];

  TextEditingController searchController = new TextEditingController();
  bool iconCrossVisibility=false;
  bool iconCancelVisibility=false;
  bool rowVisibility=false;
  bool photos=true;
  bool people=false;
  bool groups=false;
  bool noResults = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Align(
              alignment: Alignment.topLeft,
              child: ListTileTheme(
                tileColor: kSearchTextFieldColor,
                child: ListTile(
                  leading: kSearchIcon,
                  horizontalTitleGap: -4,
                  title: TextField(
                    style: TextStyle(
                      fontFamily: 'Frutiger',
                      color: Colors.white,
                    ),
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Flickr',
                      hintStyle: TextStyle(
                        fontFamily: 'Frutiger',
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: kSearchIconColor,
                      ),
                      border: InputBorder.none,
                    ),
                    onTap: (){
                      setState(() {
                        iconCancelVisibility=true;
                        rowVisibility=true;
                      });
                    },
                    onChanged: (String str) async{
                      setState(() {
                        if (searchController.text.isNotEmpty)
                        {
                          iconCrossVisibility=true;
                        }
                        else
                        {
                          iconCrossVisibility=false;
                        }
                      });
                    },
                  ),

                  trailing: Wrap(
                    children: <Widget> [
                      Visibility(
                        visible: (iconCrossVisibility == true) ? true : false,
                        child: IconButton (
                          icon: Icon(
                              Icons.cancel ),
                          color: Colors.grey[600],
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              iconCrossVisibility = false;
                            });

                          },
                        ),
                      ),
                      Visibility(
                        visible: (iconCancelVisibility == true) ? true : false,
                        child: TextButton (
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(kSearchTextFieldColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              rowVisibility = false;
                              iconCrossVisibility = false;
                              iconCancelVisibility = false;
                              photos=false;
                              people=false;
                              groups=false;
                            });
                          },
                          child: Text('Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Frutiger',
                            fontSize: 16.0,
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: (rowVisibility == true) ? true : false,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton (
                     onPressed: () {
                      setState(() {
                        photos=true;
                        people=false;
                        groups=false;
                      });
                      },
                      child: Text(
                          'Photos',
                        style: (photos==true) ? selectedText : TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20.0,

                        ),
                      ),
                ),
                  ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton (
                        onPressed: () {
                          setState(() {
                            photos=false;
                            people=true;
                            groups=false;
                          });
                        },
                        child: Text(
                          'People',
                          style: (people==true) ? selectedText : TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton (
                        onPressed: () {
                          setState(() {
                            photos=false;
                            people=false;
                            groups=true;
                          });
                        },
                        child: Text(
                          'Groups',
                          style: (groups==true) ? selectedText : TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Visibility(
            //   visible: (photos == true) ? true : false,
            // ),
             Visibility(
               visible: (people == true) ? true : false,
               child: UserCard(authorName: "SpongeBob",
                 authorImage: "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
               numberOfPhotos: '456',
               numberOfFollowers: '2.4k'),
             ),
             Visibility(
               visible: (groups == true) ? true : false,
               child: Column(
                 children: <Widget> [ GroupCard(authorName: "SpongeBob Lovers",
                      authorImage: "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
                     numberOfPhotos: '456',
                     numberOfMembers: '135'),
                   GroupCard(authorName: "SpongeBob Haterss",
                       authorImage: "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
                       numberOfPhotos: '456',
                       numberOfMembers: '135'),
                   GroupCard(authorName: "SpongeBob betngan",
                       authorImage: "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
                       numberOfPhotos: '456',
                       numberOfMembers: '135'),
                   GroupCard(authorName: "SpongeBob zeft",
                       authorImage: "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
                       numberOfPhotos: '456',
                       numberOfMembers: '135'),
                   GroupCard(authorName: "SpongeBob nila",
                       authorImage: "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
                       numberOfPhotos: '456',
                       numberOfMembers: '135'),
               ],
               ),
             ),
             //////////////////////////////////////If no results were found show this/////////////////////////////
             // Visibility(
             //   visible: (noResults == true) ? true : false,
             //   child: Container(
             //     color: kBackgroundColor,
             //     child: Column(
             //       mainAxisAlignment: MainAxisAlignment.center,
             //       crossAxisAlignment: CrossAxisAlignment.center,
             //       children: <Widget> [
             //         kSearchIcon,
             //         SizedBox(height: 15.0),
             //         Text('No results found',
             //         ),
             //       ],
             //     ),
             //   ),
             // ),
          ],
        ),
    ),
    );
  }
}


