import 'dart:convert';
import 'package:home_stay/module/currentUser.dart';
import 'package:home_stay/pages/description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import "../module/getFavourite.dart";
import 'package:http/http.dart' as http;

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  
  Future getFavouritesData() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "token");
    print(token);
    String url = 'http://10.0.2.2:8000/user/favourite';
    // var response = await Dio().get('http://10.0.2.2:8000/user/favourite', options: 
    //     Options( headers: {
    //         'Authorization': "Bearer ${token}",
    // }));
    var response = await http.get(Uri.http('10.0.2.2:8000', 'user/favourite'), headers: {"Authorization": "Bearer ${token}"});
    print(response.body);
    List<dynamic> jsonData = jsonDecode(response.body);
    print(jsonData);

    List<getFavourite> favourites = [];
    for (var i in jsonData) {
      getFavourite F = getFavourite(
      i["id"], 
      i['name'], 
      i['description'], 
      i['created_at'], 
      i['location'], 
      i['price'], 
      i['website'], 
      i['image_url'], 
      i['culture_type'], 
      i['toilet_type'], 
      i['bed_type'], 
      i['cooling_soln'], 
      i['house_type'], 
      i['no_of_available_rooms'], 
      i['near_dest'], 
      i['owner_name'], 
      i['owner_phone'], 
      i['owner_email'], 
      i['image1'], 
      i['image2'], 
      i['image3'], 
      i['latitude'], 
      i['longitude']);
    
      favourites.add(F);
    }
    print(favourites.length);
    return favourites;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
                    child: FutureBuilder(
                    future: getFavouritesData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        var homedataList = snapshot.data as List<getFavourite>;
                        return ListView.builder(
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
                                                descriptionPage(
                                                    homedataList[index])),
                                      );
                                    }),
                                    child: Column(
                                      children: [
                                        // ----------------->image holder<-------------------//
                                        Container(
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  AppBar()
                                                      .preferredSize
                                                      .height) *
                                              0.25,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                homedataList[index].image_url,
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
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  AppBar()
                                                      .preferredSize
                                                      .height) *
                                              0.1,
                                          padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.025,
                                            MediaQuery.of(context).size.width *
                                                0.015,
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                            0,
                                          ),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: FittedBox(
                                                  child: Text(
                                                      homedataList[index]
                                                          .name,
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
                                                      homedataList[index]
                                                          .location,
                                                      style: GoogleFonts.lato(
                                                          fontSize: 17,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: FittedBox(
                                                  child: Text(
                                                      'Click To Learn More',
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
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ))
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Favourites extends StatefulWidget {
//   const Favourites({Key? key}) : super(key: key);

//   @override
//   _FavouritesState createState() => _FavouritesState();
// }

// class _FavouritesState extends State<Favourites> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Favourites',
//           style: GoogleFonts.lato(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: (MediaQuery.of(context).size.height -
//                       AppBar().preferredSize.height) *
//                   0.063,
//             ),
//             Container(
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: 10,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                         margin: EdgeInsets.fromLTRB(
//                             MediaQuery.of(context).size.width * 0.08,
//                             0,
//                             MediaQuery.of(context).size.width * 0.08,
//                             (MediaQuery.of(context).size.height -
//                                     AppBar().preferredSize.height) *
//                                 0.063),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         elevation: 10,
//                         child: InkWell(
//                           onTap: (() {
//                             print('Pressed');
//                           }),
//                           child: Column(
//                             children: [
//                               // upper homestay holder
//                               Container(
//                                   height: (MediaQuery.of(context).size.height -
//                                           AppBar().preferredSize.height) *
//                                       0.05,
//                                   padding: EdgeInsets.fromLTRB(
//                                       MediaQuery.of(context).size.width * 0.025,
//                                       0,
//                                       0,
//                                       0),
//                                   // color: Color(0xff533e85),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: FittedBox(
//                                       child: Text('Favourite',
//                                           style: GoogleFonts.lato(
//                                               fontSize: 20,
//                                               color: Colors.white)),
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Color(0xff533e85),
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(5),
//                                       topLeft: Radius.circular(5),
//                                     ),
//                                   )),
//                               // image holder
//                               Container(
//                                   height: (MediaQuery.of(context).size.height -
//                                           AppBar().preferredSize.height) *
//                                       0.25,
//                                   width: 350,
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                     image: AssetImage('assets/stayimage.png'),
//                                     fit: BoxFit.fill,

// ))),
//                               //lower address container
//                               Container(
//                                   padding: EdgeInsets.fromLTRB(
//                                       MediaQuery.of(context).size.width * 0.025,
//                                       0,
//                                       0,
//                                       0),
//                                   height: (MediaQuery.of(context).size.height -
//                                           AppBar().preferredSize.height) *
//                                       0.05,
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: FittedBox(
//                                       child: Text('kathmandu',
//                                           style: GoogleFonts.lato(
//                                             fontSize: 20,
//                                             color: Colors.white,
//                                           )),
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Color(0xff533e85),
//                                     borderRadius: BorderRadius.only(
//                                       bottomRight: Radius.circular(5),
//                                       bottomLeft: Radius.circular(5),
//                                     ),
//                                   )),
//                             ],
//                           ),
//                         ));
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }