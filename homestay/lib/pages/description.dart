// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_stay/module/addBooking.dart';
import 'package:home_stay/module/gridview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './reservation.dart';
import '../module/homedata.dart';
import "../module/faourites.dart";

class descriptionPage extends StatefulWidget {
  late homedata descriptionData;
  descriptionPage(descriptionData) {
    this.descriptionData = descriptionData;
  }

  @override
  State<descriptionPage> createState() => _descriptionPageState();
}

class _descriptionPageState extends State<descriptionPage> {
  Future<bool> postFavourite(AddFavourite favourite) async {
    String jsonFavourite = jsonEncode(favourite);
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "token");
    print(token);
    try {
      var response = await Dio().post('http://10.0.2.2:8000/user/favourite',
          data: jsonFavourite,
          options: Options(headers: {
            'Authorization': "Bearer ${token}",
          }));
      print(response.data);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool isFavourite = false;
  late String imageLink;
  @override
  void _toggleFavourite() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  void showAlertDialog(BuildContext context, imageLink) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: InteractiveViewer(
            // clipBehavior: Clip.none,
            child: Image(
              image: NetworkImage(imageLink),
              fit: BoxFit.fill,
            ),
          ),
          insetPadding: EdgeInsets.all(5),
          contentPadding: EdgeInsets.all(5),
        ),
      );

  Widget build(BuildContext context) {
    List<String> images = [
      widget.descriptionData.image1,
      widget.descriptionData.image2,
      widget.descriptionData.image3
    ];
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
                              onPressed: () async {
                                int homestay_id = widget.descriptionData.id;
                                AddFavourite add_favourite =
                                    AddFavourite(homestay_id: homestay_id);
                                bool added = await postFavourite(add_favourite);
                                if (added) {
                                  _toggleFavourite();
                                }
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
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Text('Location: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text(widget.descriptionData.latitude +
                                  '    ' +
                                  widget.descriptionData.longitude),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: Text(
                              'Description :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 3, 0, 10),
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
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.descriptionData.near_destinations,
                                )
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
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showAlertDialog(
                                        context, widget.descriptionData.image1);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            widget.descriptionData.image1),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showAlertDialog(
                                        context, widget.descriptionData.image2);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            widget.descriptionData.image2),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showAlertDialog(
                                        context, widget.descriptionData.image3);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            widget.descriptionData.image3),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // gridLayout(
                            //   images
                            // ),
                            //
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                            child: Text(
                              'Contact Owner:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text('Email : ' +
                                '  ' +
                                widget.descriptionData.owner_email),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text('Name : ' +
                                '  ' +
                                widget.descriptionData.owner_name),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text('Phone : ' +
                                '  ' +
                                widget.descriptionData.owner_phone),
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => reservation(
                                          widget.descriptionData.image_url,
                                          widget.descriptionData
                                              .no_of_available_rooms,
                                          widget.descriptionData.homestay_name,
                                          widget.descriptionData.id),
                                    ),
                                  );
                                },
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
