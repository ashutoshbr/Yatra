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
      homedata H = homedata(h['id'], h['name'], h['image_url'], h['location'], h['created_at'], h['description'], h['toilet_type'], h['price'], h['culture_type'], h['bed_type'], h['cooling_soln'], h['house_type'], h['website'], h['near_dest'], h['no_of_available_rooms'], h['owner_name'], h['owner_phone'], h['owner_email'], h['image1'], h['image2'], h['image3'], h['latitude'], h['longitude']);

      homedataList.add(H);
    }
    print(homedataList.length);
    return homedataList;
  }

  

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
                onPressed: () {
                  getHomestayData();
                },
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
              child: FutureBuilder (
                future: getHomestayData(),
                builder: (context, snapshot){
                  if(snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  else if(snapshot.hasData) {
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
                                            homedataList[index].location,
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
                  });
                  }
                  else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
