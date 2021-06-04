import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../home/profile/profilePages/Albums/albums.dart';
import '../home/profile/profile_screen.dart';

import '../home/home.dart';




/// @imagePath : the path of the image relative to Assets file,
/// @title : the title displayed in the page
/// @firstLine , @secondLine : the two lines displayed at the bottom of the page
class page extends StatelessWidget {
  page(
      {@required this.imagePath,
      @required this.title,
      @required this.firstLine,
      @required this.secondLine});



  final String imagePath;
  final String title;
  final String firstLine;
  final String secondLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/$imagePath"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 430,
          ),
          Text(
            "$title",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Frutiger',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "$firstLine",
            // "Save all your photos and videos",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Frutiger',
              color: Colors.white,
            ),
          ),
          Text(
            "$secondLine",
            // "in one place with Auto-Uploadr.",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Frutiger',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}


/// this widget contains a 4 pages of [page] widget and swipe between them by [SmoothPageIndicator]

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {


  PageController _pageController = new PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              children: [
                page(
                  imagePath: "p1.jpg",
                  title: "Powerful",
                  firstLine: "Save all your photos and videos",
                  secondLine: "in one place with Auto-Uploadr.",
                ),
                page(
                  imagePath: "p2.jpg",
                  title: "Organization simplified",
                  firstLine: "Search, edit, and organize",
                  secondLine: "in seconds.",
                ),
                page(
                  imagePath: "p3.jpg",
                  title: "Keep your memories safe",
                  firstLine: "Your uploaded photos stay private",
                  secondLine: "until you choose to share them.",
                ),
                page(
                  imagePath: "p4.jpg",
                  title: "Sharing made easy",
                  firstLine: "Share with friends, family, and",
                  secondLine: "the world.",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 350,
                ),
                Text(
                  "flickr",
                  style: TextStyle(
                    fontSize: 70,
                    fontFamily: 'Frutiger',
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.15,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment(-1, -1),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 4,
                        effect: ScrollingDotsEffect(
                            radius: 4,
                            dotHeight: 8,
                            dotWidth: 8,
                            dotColor: Colors.grey,
                            activeDotColor: Colors.white),
                        onDotClicked: (index) => _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 100)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'LogIn');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return Profile();
                    //     },
                    //   ),
                    // );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => Colors.transparent),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ), //MaterialProperty
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 15),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Frutiger',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
