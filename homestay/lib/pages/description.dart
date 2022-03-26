// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_stay/onboarding/homepage.dart';

class descriptionPage extends StatefulWidget {
  late String homestayname;
  late String address;
  late String city;
  descriptionPage(
      {required this.homestayname, required this.address, required this.city});

  @override
  State<descriptionPage> createState() => _descriptionPageState();
}

class _descriptionPageState extends State<descriptionPage> {
  String price = '\$ 80/day';
  String home_type = 'Cottage';
  List<String> attraction = [
    'Phew Lake',
    'Paragliding',
    'skydiving',
    'swimming'
  ];
  List<String> latrineTpye = ['European', 'Classic'];
  String description =
      ' Go imply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';
  String ownerMail = 'imrich@gmail.com';
  String ownerPhone = '9800000000';
  String ownerTelephone = '01-222222';

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
        title: FittedBox(child: Text(widget.homestayname)),
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
                  image: AssetImage('assets/stayimage.png'),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: FittedBox(
                              child: Text(
                                widget.homestayname,
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 18,
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
                  // width: MediaQuery.of(context).size.width * 1,
                  // height: MediaQuery.of(context).size.height * 0.,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
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
                                Text(widget.address + ',' + ' ' + widget.city),
                              ],
                            ),
                            Text(price),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('House Type :' + ' ' + home_type),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text(
                              'Major Attraction : phewa lake, sarangkot, paragliding'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Latrine : ' + latrineTpye.first),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Included : Breakfast, Lunch, Dinner'),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        //   child: Row(
                        //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text('Add to Favourite'),

                        //       //----------------->favourite icon<------------------//

                        //       IconButton(
                        //         onPressed: () {
                        //           _toggleFavourite();
                        //         },
                        //         icon: isFavourite
                        //             ? Icon(
                        //                 Icons.favorite,
                        //                 color: Theme.of(context).primaryColor,
                        //               )
                        //             : Icon(
                        //                 Icons.favorite_border,
                        //                 color: Theme.of(context).primaryColor,
                        //               ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Description :'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 8, 0, 10),
                          child: Text(
                            description,
                            style: TextStyle(
                              height: 2,
                            ),
                          ),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text(
                            'Contact :',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Email : ' + ownerMail),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Phone : ' + ownerPhone),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text('Telephone : ' + ownerTelephone),
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
