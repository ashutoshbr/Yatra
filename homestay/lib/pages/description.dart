// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  image: NetworkImage(widget.descriptionData.image_url),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // ---------->includes all the description including name of the homestay<------------------------//
            // ---------->inside a single container <---------------------//
            Container(
              decoration: BoxDecoration(
                color: Color(0xff533e85),
              ),
              child: Column(
                children: [
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
                            // -------------> contains fav icon <-------------------//
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
                                  Text(
                                    widget.descriptionData.location,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                '\$' +
                                    '${widget.descriptionData.price}'
                                        '/day',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                                child: Text(
                                  'House Type :',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(widget.descriptionData.house_type)
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                                child: Text(
                                  'Cooling Solution : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                widget.descriptionData.cooling_soln,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                                child: Text(
                                  'Latrine : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(widget.descriptionData.toilet_type)
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child:
                                Text('Included :   Breakfast, Lunch, Dinner'),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: Text(
                              'Description :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Major Attraction:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.descriptionData
                                        .near_destinations.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 8, 0, 8),
                                        child: Text('${index + 1 * 1}' +
                                            '.' +
                                            ' ' +
                                            widget.descriptionData
                                                .near_destinations),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: Text(
                              'HomeStay Images :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                            child: Text(
                              'Contact :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Email : ' + '  ' + 'owner@gmail.com'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Phone : ' + '  ' + '984111111'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Telephone : ' + '  ' + '01-83393993'),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // ------------> reservation button <-------------- //
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
                          Center(
                              child: Text(
                                  'Note: It\'s just a Reservation not a Booking')),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),

                  //-----------> description box details <----------------//
                ],
              ),
            ),
            // ---------->where description and fav list container ends <-------------- //
          ],
        ),
      ),
    );
  }
}
