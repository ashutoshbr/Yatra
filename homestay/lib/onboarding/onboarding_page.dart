import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/svg.dart';
import '../onboarding/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/colors.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: IntroductionScreen(
          isProgress: true,
          pages: [
            PageViewModel(
              title: 'Home Stay',
              body: 'Home Stay Where You Feel Home !!',
              image: buildImage('assets/house.svg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Travel To Home',
              body: 'Travel to Nepal Where Home Lies',
              image: buildImage('assets/image1.svg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Live With Locals',
              body:
                  'Live With Locals And Enjoy The Culture And Livelihood Together',
              image: buildImage('assets/culture.svg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'You Are Ready! ',
              body: 'You Are Well Set To Explore Available Home Stay ',
              image: buildImage('assets/last.svg'),
              footer: ButtonTheme(
                height: 50.0,
                minWidth: 200,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(homePage.routeName);
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              decoration: getPageDecoration(),
            )
          ],
          done: Text(
            'Continue',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onDone: () {
            Navigator.of(context).pushReplacementNamed(homePage.routeName);
          },
          showNextButton: true,
          next: Icon(Icons.arrow_forward),
          showSkipButton: true,
          skip: Text(
            'Skip',
          ),
          animationDuration: 300,
        ),
      ),
    );
  }
}

Widget buildImage(String path) {
  return Center(
    child: SvgPicture.asset(
      path,
      // fit: BoxFit.fitHeight,
    ),
  );
}

Widget buildImage1(String path) {
  return Center(
    child: Image.asset(
      path,
      width: 250,
    ),
  );
}

PageDecoration getPageDecoration() {
  return PageDecoration(
    titleTextStyle: GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    bodyTextStyle: GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      height: 1.5,
      fontSize: 22,
    ),
    bodyPadding: EdgeInsets.all(25).copyWith(bottom: 0),
    pageColor: Colors.white12,
  );
}
