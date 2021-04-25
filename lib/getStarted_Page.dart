import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login/login_screen.dart';

class Page extends StatelessWidget {
  Page(
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
                Page(
                  imagePath: "p1.jpg",
                  title: "Powerful",
                  firstLine: "Save all your photos and videos",
                  secondLine: "in one place with Auto-Uploadr.",
                ),
                Page(
                  imagePath: "p2.jpg",
                  title: "Organization simplified",
                  firstLine: "Search, edit, and organize",
                  secondLine: "in seconds.",
                ),
                Page(
                  imagePath: "p3.jpg",
                  title: "Keep your memories safe",
                  firstLine: "Your uploaded photos stay private",
                  secondLine: "until you choose to share them.",
                ),
                Page(
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
                Container(
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoggingInScreen();
                        },
                      ),
                    );
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
