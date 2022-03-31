// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_stay/onboarding/homepage.dart';
import '../module/homedata.dart';

class descriptionPage extends StatefulWidget {
  late homedata descriptionData;
  descriptionPage(descriptionData) {
    this.descriptionData = descriptionData;
  }

  @override
  State<descriptionPage> createState() => _descriptionPageState();
}

class _descriptionPageState extends State<descriptionPage> {
  bool isFavourite = false;
  @override
  void _toggleFavourite() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(widget.descriptionData.homestay_name)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) *
                  0.3,
              // width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.descriptionData.homestay_photo),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // ---------->includes all the description including name of the homestay<------------------------//
            Container(
              decoration: BoxDecoration(
                color: Color(0xff533e85),
              ),
              child: Column(children: [
                //------------>contains the name of the homestay<---------------//
                Container(
                  height: (MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height) *
                      0.080,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.descriptionData.homestay_name,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _toggleFavourite();
                            },
                            icon: isFavourite
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                          ),
                        ]),
                  ),
                ),
                //---------------->contains details like address, description etc.<--------------//
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(widget.descriptionData.homestay_city +
                                    ',' +
                                    ' ' +
                                    widget.descriptionData.homestay_district),
                              ],
                            ),
                            Text('\$' +
                                '${widget.descriptionData.price * 1}' '/day'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('House Type :' +
                              ' ' +
                              widget.descriptionData.houseType),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Major Attraction : ' +
                              widget.descriptionData.nearDestination[1]),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Latrine : ' +
                              widget.descriptionData.latrineType),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Included : Breakfast, Lunch, Dinner'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Description :'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 8, 0, 10),
                          child: Text(
                            widget.descriptionData.description,
                            style: TextStyle(
                              height: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text(
                            'Contact :',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Email : ' + 'owner@gmail.com'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Phone : ' + '984111111'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Telephone : ' + '01-83393993'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              child: Text(
                                'Reserve',
                                style: GoogleFonts.lato(fontSize: 20),
                              ),
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
