import 'dart:convert';
import 'dart:ui';
import 'package:home_stay/pages/description.dart';
import 'package:http/http.dart' as http;
import './favourites.dart';
import 'package:flutter/material.dart';
import 'package:home_stay/colors/colors.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../module/homedata.dart';
import 'package:geolocator/geolocator.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  Future getHomestayData() async {
    // var response = await http.get(Uri.http('10.0.2.2:8000', 'homestay'));
    var response = await http.get(Uri.http('10.0.2.2:8000', 'homestay'));
    var jsonData = jsonDecode(response.body);

    List<homedata> homedataList = [];
    for (var h in jsonData) {
      homedata H = homedata(
          h['id'],
          h['name'],
          h['image_url'],
          h['location'],
          h['created_at'],
          h['description'],
          h['toilet_type'],
          h['price'],
          h['culture_type'],
          h['bed_type'],
          h['cooling_soln'],
          h['house_type'],
          h['website'],
          h['near_dest'],
          h['no_of_available_rooms'],
          h['owner_name'],
          h['owner_phone'],
          h['owner_email'],
          h['image1'],
          h['image2'],
          h['image3'],
          h['latitude'],
          h['longitude']);

      homedataList.add(H);
    }
    print(homedataList);
    print(homedataList.length);
    return homedataList;
  }

  Future getNearHomestayData() async {
    // var response = await http.get(Uri.http('10.0.2.2:8000', 'homestay'));
    var response = await http.get(Uri.http('10.0.2.2:8000', 'homestay'));
    var jsonData = jsonDecode(response.body);

    List<homedata> NearhomedataList = [];
    for (var h in jsonData) {
      homedata H = homedata(
          h['id'],
          h['name'],
          h['image_url'],
          h['location'],
          h['created_at'],
          h['description'],
          h['toilet_type'],
          h['price'],
          h['culture_type'],
          h['bed_type'],
          h['cooling_soln'],
          h['house_type'],
          h['website'],
          h['near_dest'],
          h['no_of_available_rooms'],
          h['owner_name'],
          h['owner_phone'],
          h['owner_email'],
          h['image1'],
          h['image2'],
          h['image3'],
          h['latitude'],
          h['longitude']);

      NearhomedataList.add(H);
    }
    print(NearhomedataList);
    print(NearhomedataList.length);
    return NearhomedataList;
  }

  _loadData() async {
    await getHomestayData();
    await getNearHomestayData();
  }

  late String currentLat = '';
  late String currentLog = '';

  @override
  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not given");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        currentLat = currentPosition.latitude.toString();
        currentLog = currentPosition.longitude.toString();
      });

      print('Latitude: ' + currentLat);
      print('Longitude: ' + currentLog);
    }
  }

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
                  0.02,
            ),
            Container(
              child: currentLat != '' && currentLog != ''
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Homestays within 20 KM',
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.filter_list,
                                      color: Theme.of(context).primaryColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            FutureBuilder(
                              future: getNearHomestayData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                } else if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  var nearhomedataList =
                                      snapshot.data as List<homedata>;
                                  return Column(
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: nearhomedataList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return (double.parse(currentLat) - double.parse(nearhomedataList[index].latitude))
                                                            .abs() <
                                                        0.2 &&
                                                    (double.parse(currentLog) -
                                                                double.parse(
                                                                    nearhomedataList[index]
                                                                        .longitude))
                                                            .abs() <
                                                        0.2
                                                ? Card(
                                                    margin: EdgeInsets.fromLTRB(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        0,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .height -
                                                                AppBar()
                                                                    .preferredSize
                                                                    .height) *
                                                            0.05),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    elevation: 15,
                                                    child: InkWell(
                                                      onTap: (() {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  descriptionPage(
                                                                      nearhomedataList[
                                                                          index])),
                                                        );
                                                      }),
                                                      child: Column(
                                                        children: [
                                                          // ----------------->image holder<-------------------//
                                                          Container(
                                                            height: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height -
                                                                    AppBar()
                                                                        .preferredSize
                                                                        .height) *
                                                                0.25,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    NetworkImage(
                                                                  nearhomedataList[
                                                                          index]
                                                                      .image_url,
                                                                ),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5),
                                                              ),
                                                            ),
                                                          ),
                                                          // ------------->Homestay name and Addresss<------------------//
                                                          Container(
                                                            height: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height -
                                                                    AppBar()
                                                                        .preferredSize
                                                                        .height) *
                                                                0.1,
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.025,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.015,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.02,
                                                              0,
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      FittedBox(
                                                                    child: Text(
                                                                        nearhomedataList[index]
                                                                            .homestay_name,
                                                                        style: GoogleFonts.lato(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.white)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      FittedBox(
                                                                    child: Text(
                                                                        nearhomedataList[index]
                                                                            .location,
                                                                        style: GoogleFonts.lato(
                                                                            fontSize:
                                                                                17,
                                                                            color:
                                                                                Colors.white)),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child:
                                                                      FittedBox(
                                                                    child: Text(
                                                                        'Click To Learn More',
                                                                        style: GoogleFonts.lato(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.white)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff533e85),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        5),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                : Container(
                                                    height: 0,
                                                  );
                                          }),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, bottom: 20),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Available HomeStays',
                                                  style: GoogleFonts.lato(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Icon(Icons.filter_list,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: (MediaQuery.of(context)
                                      //               .size
                                      //               .height -
                                      //           AppBar().preferredSize.height) *
                                      //       0.05,
                                      // ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: nearhomedataList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Card(
                                                margin: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.04,
                                                    0,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.04,
                                                    (MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            AppBar()
                                                                .preferredSize
                                                                .height) *
                                                        0.05),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                elevation: 15,
                                                child: InkWell(
                                                  onTap: (() {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              descriptionPage(
                                                                  nearhomedataList[
                                                                      index])),
                                                    );
                                                  }),
                                                  child: Column(
                                                    children: [
                                                      // ----------------->image holder<-------------------//
                                                      Container(
                                                        height: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height -
                                                                AppBar()
                                                                    .preferredSize
                                                                    .height) *
                                                            0.25,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              nearhomedataList[
                                                                      index]
                                                                  .image_url,
                                                            ),
                                                            fit: BoxFit.fill,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                        ),
                                                      ),
                                                      // ------------->Homestay name and Addresss<------------------//
                                                      Container(
                                                        height: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height -
                                                                AppBar()
                                                                    .preferredSize
                                                                    .height) *
                                                            0.1,
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.025,
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.015,
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                          0,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: FittedBox(
                                                                child: Text(
                                                                    nearhomedataList[
                                                                            index]
                                                                        .homestay_name,
                                                                    style: GoogleFonts.lato(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: FittedBox(
                                                                child: Text(
                                                                    nearhomedataList[
                                                                            index]
                                                                        .location,
                                                                    style: GoogleFonts.lato(
                                                                        fontSize:
                                                                            17,
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: FittedBox(
                                                                child: Text(
                                                                    'Click To Learn More',
                                                                    style: GoogleFonts.lato(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xff533e85),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          }),
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(
                      height: 0,
                    ),
            ),
            currentLat == '' && currentLog == ''
                ? Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              'Available HomeStays',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.filter_list,
                                color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(height: 0),
            currentLat == '' && currentLog == ''
                ?
                // SizedBox(
                //   height: (MediaQuery.of(context).size.height -
                //           AppBar().preferredSize.height) *
                //       0.0,
                // ): Container(height:0),
                // currentLat == '' && currentLog == '' ?
                Container(
                    child: FutureBuilder(
                    future: getHomestayData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        var homedataList = snapshot.data as List<homedata>;
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
                                                          .homestay_name,
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
                : Container(height: 0)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getCurrentPosition();
        },
        icon: Icon(Icons.location_history),
        label: Text('Near you'),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class MainHome extends StatefulWidget {
//   const MainHome({ Key? key }) : super(key: key);

//   @override
//   State<MainHome> createState() => _MainHomeState();
// }

// class _MainHomeState extends State<MainHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }