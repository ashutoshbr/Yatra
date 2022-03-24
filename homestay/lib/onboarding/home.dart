import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './homepage.dart';
import './onboarding_page.dart';
import '../main.dart';
import '../colors/colors.dart';
import '../login/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF533E85, color),
      ),
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage(),
      routes: {
        homePage.routeName: (Ctx) => logIn(),
      },
    );
  }
}
