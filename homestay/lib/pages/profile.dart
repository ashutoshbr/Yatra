// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import '../login/login.dart';
import 'package:home_stay/onboarding/onboarding_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // top up box "do u want to log out?"
  void showAlertDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Log Out?',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text(
            "Do you want to log out?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => logIn(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child:
                    Text('Yes', style: Theme.of(context).textTheme.bodyText2)),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                child:
                    Text('No', style: Theme.of(context).textTheme.bodyText2)),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.35,
              (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) *
                  0.05,
              MediaQuery.of(context).size.width * 0.35,
              0),
          padding: EdgeInsets.all(10),
          height: (MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height) *
              0.2,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/profile.png'),
              // fit: BoxFit.fill,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FittedBox(
              child: Text('@username123',
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: Color(0xff533e85),
                  )),
            ),
          ),
        ),
        // gap between profile photo and cards
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        // the email showing card
        Card(
          margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.08,
              0,
              MediaQuery.of(context).size.width * 0.08,
              (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) *
                  0.03),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Container(
            height: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height) *
                0.07,
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.025,
                0,
                MediaQuery.of(context).size.width * 0.025,
                0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    child: Text('Email :',
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      child: Text('user123@gmail.com',
                          style: GoogleFonts.lato(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor)),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        // the log out card
        Card(
          margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.08,
              0,
              MediaQuery.of(context).size.width * 0.08,
              (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) *
                  0.03),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: InkWell(
            onTap: (() {
              showAlertDialog(context);
            }),
            child: Container(
              height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) *
                  0.07,
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.025,
                  0,
                  MediaQuery.of(context).size.width * 0.025,
                  0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text('Log Out',
                            style: GoogleFonts.lato(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor)),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: (() {
                              showAlertDialog(context);
                            }),
                            icon: Icon(Icons.logout,
                                color: Theme.of(context).primaryColor),
                          ),
                        ))
                  ]),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        )
      ]),
    );
  }
}
