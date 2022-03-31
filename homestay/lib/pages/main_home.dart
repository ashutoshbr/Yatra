import 'dart:ui';
import 'package:home_stay/pages/description.dart';

import './favourites.dart';
import 'package:flutter/material.dart';
import 'package:home_stay/colors/colors.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../module/homedata.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final List<homedata> homedataList = [
    homedata(
        'Local Homestay',
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
        'Pokhara',
        'Kathmandu',
        false,
        'that was a great show',
        'European',
        10,
        'Newari',
        'single bed',
        'very cold',
        'cottage',
        444444,
        ['Phewa', 'Rara', 'Sarangkot']),
    homedata(
      'Europe Homestay very very very very rich very very vry very everyer  verygeryveyrye veyrh',
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
      'Thamel',
      'Kathmandu',
      false,
      'that was a great show',
      'European',
      100,
      'Tharu',
      'single bed and double bed',
      'very cold',
      'Building',
      4454,
      ['Phewa', 'Rara' 'Sarangkor'],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Home Stay',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) *
                  0.04,
            ),
            SizedBox(
              width: 300,
              height: 40,
              child: ElevatedButton(
                child: Text(
                  'Available HomeStays',
                  style: GoogleFonts.lato(fontSize: 20),
                ),
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) *
                  0.05,
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homedataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.04,
                            0,
                            MediaQuery.of(context).size.width * 0.04,
                            (MediaQuery.of(context).size.height -
                                    AppBar().preferredSize.height) *
                                0.05),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15,
                        child: InkWell(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      descriptionPage(homedataList[index])),
                            );
                          }),
                          child: Column(
                            children: [
                              // ----------------->image holder<-------------------//
                              Container(
                                height: (MediaQuery.of(context).size.height -
                                        AppBar().preferredSize.height) *
                                    0.25,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      homedataList[index].homestay_photo,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                  ),
                                ),
                              ),
                              // ------------->Homestay name and Addresss<------------------//
                              Container(
                                height: (MediaQuery.of(context).size.height -
                                        AppBar().preferredSize.height) *
                                    0.1,
                                padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.025,
                                  MediaQuery.of(context).size.width * 0.015,
                                  MediaQuery.of(context).size.width * 0.02,
                                  0,
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        child: Text(
                                            homedataList[index].homestay_name,
                                            style: GoogleFonts.lato(
                                                fontSize: 20,
                                                color: Colors.white)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        child: Text(
                                            homedataList[index].homestay_city +
                                                ',' +
                                                ' ' +
                                                homedataList[index]
                                                    .homestay_district,
                                            style: GoogleFonts.lato(
                                                fontSize: 17,
                                                color: Colors.white)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: FittedBox(
                                        child: Text('Click To Learn More',
                                            style: GoogleFonts.lato(
                                                fontSize: 10,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xff533e85),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
