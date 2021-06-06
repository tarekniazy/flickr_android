import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../signup/signupStyling/signup_Widgets.dart';
import '../../home/customeWidgets.dart';
import '../customeWidgets.dart';
import '../../constants.dart';
import '../../Services/networking.dart';
import 'dart:convert';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotoCard> photoSearchList = [];
  List<PhotoCard> photoList = [];
  List<GroupCard> groupList = [];
  List<UserCard> usersList = [];

  void LoadPhoto() async {
    photoList.clear();
    NetworkHelper req2 = new NetworkHelper("$KBaseUrl/photo/explore");
    var res2 = await req2.getData(true);
    // print(res2.statusCode);
    if (res2.statusCode == 200) {
      String data2 = res2.body;
      List<dynamic> response2 = jsonDecode(data2);
      // print(response2);
      setState(() {
        response2.forEach((element) {
          print(element["photoUrl"]);
          photoList.add(PhotoCard(imageUrl: element["photoUrl"]));
        });
      });
    }
    // else
    // {
    //   print(res2.statusCode);
    // }
  }

  void loadGroupCard(List<dynamic> groups) {
    groupList.clear();

    groups.forEach((element) {
      groupList.add(GroupCard(group_id:element["_id"] ,
          authorName: element["name"],
          authorImage:
              "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
          numberOfPhotos: element["num_photos"].toString(),
          numberOfMembers: element["num_members"].toString()));
    });
  }

  void loadPhotoCard(List<dynamic> photos) {
    photoSearchList.clear();
    photos.forEach((element) {
      photoSearchList.add(PhotoCard(imageUrl: element["photoUrl"]));
    });
  }

  void loadUserCard(List<dynamic> users) {
    usersList.clear();
    users.forEach((element) {
      usersList.add(UserCard(
        authorName: element["UserName"],
        authorImage: element["avatarUrl"],
        numberOfPhotos: element["numberOfPublicPhotos"].toString(),
        numberOfFollowers: element["numberOfFollowers"].toString(),
        isFollowed: element["isFollowed"],
        peopleID: element['_id'],
      ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List<dynamic> users = [
      {
        "Fname": "Mariam",
        "Lname": "Ameen",
        "UserName": "MariamAmeen",
        "_id": 0,
        "Date_joined": "2021-05-31",
        "numberOfPublicPhotos": 2,
        "numberOfFollowers": 5,
        "avatarUrl":
            "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
        "isFollowed": false
      },
      {
        "Fname": "Mariam",
        "Lname": "Ameen",
        "UserName": "MariamAmeen",
        "_id": 0,
        "Date_joined": "2021-05-31",
        "numberOfPublicPhotos": 0,
        "numberOfFollowers": 0,
        "avatarUrl":
            "https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "isFollowed": true
      }
    ];
    // loadUserCard(users);

    // List<dynamic> groups=[
    //   {
    //     "description": null,
    //     "privacy": "public",
    //     "visibility": "public",
    //     "id": "608c80ce54e3d74b34d9bb5a",
    //     "name": "ABC",
    //     "num_photos": 0,
    //     "num_members": 1,
    //     "role": "member"
    //   }
    //   ,
    //   {
    //     "description": null,
    //     "privacy": "public",
    //     "visibility": "public",
    //     "id": "608c80ce54e3d74b34d9bb5a",
    //     "name": "ABC",
    //     "num_photos": 0,
    //     "num_members": 1,
    //     "role": "member"
    //   }
    // ];

    //     {
    //   "_id": 0,
    // "photoUrl": "http://localhost:3000/api/v1/image/0",
    // "ownerId": 0,
    // "Fav": [
    // 0
    // ],
    // "comments": [
    // 0
    // ],
    // "title": 0,
    // "privacy": "string",
    // "description": "string",
    // "tags": [
    // "string"
    // ],
    // "peopleTags": [
    // {
    // "tagging": "string",
    // "tagged": [
    // "string"
    // ]
    // }
    // ],
    // "createdAt": "2021-06-01",
    // "UpdatedAt": "2021-06-01"
    // }

    List<dynamic> photos = [
      {
        "title": "profile",
        "description": "",
        "Fav": [],
        "privacy": "public",
        "tags": [],
        "_id": "60b3ede89ee9b94fb8b6d633",
        "ownerId": "60b3ed529ee9b94fb8b6d632",
        "photoUrl": "localhost:3000/photos\\2021-05-30T19-56-24.816Z1.jpeg",
        "peopleTags": [],
        "comments": [],
        "createdAt": "2021-05-30T19:56:24.824Z",
        "updatedAt": "2021-05-30T19:56:24.824Z",
        "__v": 0,
        "no_comments": 0,
        "no_fav": 0,
        "UserName": "ashrafosama536"
      },
      {
        "title": "profile",
        "description": "",
        "Fav": [],
        "privacy": "public",
        "tags": [],
        "_id": "60b3ede89ee9b94fb8b6d633",
        "ownerId": "60b3ed529ee9b94fb8b6d632",
        "photoUrl": "localhost:3000/photos\\2021-05-30T19-56-24.816Z1.jpeg",
        "peopleTags": [],
        "comments": [],
        "createdAt": "2021-05-30T19:56:24.824Z",
        "updatedAt": "2021-05-30T19:56:24.824Z",
        "__v": 0,
        "no_comments": 0,
        "no_fav": 0,
        "UserName": "ashrafosama536"
      }
    ];
    // loadPhotoCard(photos);
    LoadPhoto();
  }

  // List<PhotoCard> photoPost = [
  //   PhotoCard(
  //       imageUrl:
  //       "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg"),
  //
  //   PhotoCard(
  //
  //       imageUrl:
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTTKDd_d5wfvokkE5cdLjgMw9v5N9UNOovRg&usqp=CAU"),
  //   PhotoCard(
  //       imageUrl:
  //       "https://cdn.shopify.com/s/files/1/2726/1450/products/RE_Spongebob_Patrick-fig_NYCC_2048_64e13260-ad62-46dd-a617-e6752597dc22_600x600.jpg?v=160452973033"),
  //
  //   PhotoCard(
  //
  //       imageUrl:
  //       "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg"),
  //
  //   PhotoCard(
  //       imageUrl:
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTTKDd_d5wfvokkE5cdLjgMw9v5N9UNOovRg&usqp=CAU")
  //
  // ];

  TextEditingController searchController = new TextEditingController();
  bool iconCrossVisibility = false;
  bool iconCancelVisibility = false;
  bool rowVisibility = false;
  bool randomPhotos = true;
  bool photos = false;
  bool people = false;
  bool groups = false;
  bool noResults = false;
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
                  onTap: () {
                    setState(() {
                      iconCancelVisibility = true;
                      rowVisibility = true;
                      randomPhotos = false;

                      x++;
                      if (x == 1) photos = true;
                    });
                  },
                  onChanged: (String str) async {
                    setState(() {
                      if (searchController.text.isNotEmpty) {
                        iconCrossVisibility = true;
                      } else {
                        iconCrossVisibility = false;
                      }
                    });
                  },
                ),
                trailing: Wrap(
                  children: <Widget>[
                    Visibility(
                      visible: (iconCrossVisibility == true) ? true : false,
                      child: IconButton(
                          icon: Icon(Icons.check, color: Colors.grey[600]),
                          onPressed: () async {
                            NetworkHelper groupreq;
                            var groupresp;

                            NetworkHelper peoplereq;
                            var peopleresp;

                            NetworkHelper photoreq;
                            var photoresp;

                            if (groups == true) {
                              groupreq = new NetworkHelper("$KBaseUrl/group/" +
                                  searchController.text +
                                  "/search");

                              groupresp = await groupreq.getData(true);
                            }

                            if (people == true) {
                               peoplereq = new NetworkHelper(
                                  "$KBaseUrl/people/search/" +
                                      searchController.text);
                              peopleresp = await peoplereq.getData(true);
                            }

                            if (photos == true) {
                               photoreq = new NetworkHelper(
                                  "$KBaseUrl/photo/getbytitle/" +
                                      searchController.text);
                              photoresp = await photoreq.getData(true);
                            }

                            setState(() {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              // noResults = false;

                              // print(searchController.text);
                              if (photos == true) {
                                if (photoresp.statusCode == 200) {
                                  String data2 = photoresp.body;
                                  List<dynamic> response2 = jsonDecode(data2);
                                  loadPhotoCard(response2);
                                } else {
                                  print(photoresp.statusCode);
                                  // noResults = true;
                                }
                              }
                              if (groups == true) {
                                if (groupresp.statusCode == 200) {
                                  String data2 = groupresp.body;
                                  List<dynamic> response2 = jsonDecode(data2);
                                  loadGroupCard(response2);
                                } else {
                                  print(groupresp.statusCode);
                                  // noResults = true;

                                }
                              }
                              if (people == true) {
                                if (peopleresp.statusCode == 201) {
                                  String data2 = peopleresp.body;
                                  List<dynamic> response2 = jsonDecode(data2);
                                  // loadGroupCard(response2);
                                  print(response2);
                                  loadUserCard(response2);
                                } else {
                                  print(peopleresp.statusCode);
                                }
                              }
                            });
                          }

                          //     setState(() {
                          //   });
                          // },
                          ),
                    ),
                    Visibility(
                      visible: (iconCrossVisibility == true) ? true : false,
                      child: IconButton(
                        icon: Icon(Icons.cancel),
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
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kSearchTextFieldColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                            photos = false;
                            people = false;
                            groups = false;
                            randomPhotos = true;
                            noResults = false;
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          });
                        },
                        child: Text(
                          'Cancel',
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
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          photos = true;
                          people = false;
                          groups = false;
                          noResults = false;
                          randomPhotos = false;
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        });
                      },
                      child: Text(
                        'Photos',
                        style: (photos == true)
                            ? selectedText
                            : TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20.0,
                              ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          photos = false;
                          people = true;
                          groups = false;
                          noResults = false;
                          randomPhotos = false;
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        });
                      },
                      child: Text(
                        'People',
                        style: (people == true)
                            ? selectedText
                            : TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20.0,
                              ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          photos = false;
                          people = false;
                          groups = true;
                          noResults = false;
                          randomPhotos = false;
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        });
                      },
                      child: Text(
                        'Groups',
                        style: (groups == true)
                            ? selectedText
                            : TextStyle(
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

          Visibility(
            visible: (photos == true) ? true : false,
            child: Expanded(
              child: new ListView.builder(
                itemCount: photoSearchList.length,
                itemBuilder: (BuildContext context, int index) {
                  return photoSearchList[index];
                },
              ),
            ),
          ),

          Visibility(
            visible: (randomPhotos == true) ? true : false,
            child: Expanded(
              child: new ListView.builder(
                itemCount: photoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return photoList[index];
                },
              ),
            ),
          ),

          Visibility(
            visible: (people == true) ? true : false,

            child: Expanded(
              child: new ListView.builder(
                itemCount: usersList.length,
                itemBuilder: (BuildContext context, int index) {
                  return usersList[index];
                },
              ),
            ),
            // child: UserView(
            //   userBody: usersList,
            // ),
          ),

          Visibility(
            visible: (groups == true) ? true : false,
            child: Expanded(
              child: new ListView.builder(
                itemCount: groupList.length,
                itemBuilder: (BuildContext context, int index) {
                  return groupList[index];
                },
              ),
            ),
          ),

          //////////////////////////////////////If no results were found show this/////////////////////////////
          Visibility(
            visible: (noResults == true) ? true : false,
            child: Container(
              color: kBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 160.0,
                  ),
                  kSearchIconLarge,
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "No results found",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Frutiger',
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 25.0),
                    child: Text(
                      'Wow. We\'ve searched high and low, but can\'t seem to find what you\'re looking for right now.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Frutiger',
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
