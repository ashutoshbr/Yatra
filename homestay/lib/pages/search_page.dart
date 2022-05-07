import "package:flutter/material.dart";
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "../module/homedata.dart";
import "./description.dart";
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class searchList extends StatefulWidget {
  late String searchText;

  searchList(searchText) {
    this.searchText = searchText;
  }

  @override
  State<searchList> createState() => _searchListState();
}

class _searchListState extends State<searchList> {
  Future _searchList() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "token");
    String url = "http://10.0.2.2:8000/search?location=" + widget.searchText;
    // String url1 = "search?location=" + widget.searchText;
    print("hello");
    print(url);
    var response = await Dio().get(url,
        options: Options(headers: {
          'Authorization': "Bearer ${token}",
        }));
    print(response.data);
    // var jsonData = jsonDecode(response.data);
    var jsonData = List<dynamic>.from(response.data);
    print(jsonData);
    List<homedata> searchResult = [];
    for (var h in jsonData) {
      homedata homestay = homedata(
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

      searchResult.add(homestay);
    }
    return searchResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search List"),
        ),
        body: FutureBuilder(
          future: _searchList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var searchResult = snapshot.data as List<homedata>;
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Search Results for:' + " " + widget.searchText,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: searchResult.length,
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
                                          descriptionPage(searchResult[index])),
                                );
                              }),
                              child: Column(
                                children: [
                                  // ----------------->image holder<-------------------//
                                  Container(
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                AppBar().preferredSize.height) *
                                            0.25,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          searchResult[index].image_url,
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
                                    height:
                                        (MediaQuery.of(context).size.height -
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
                                                searchResult[index]
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
                                                searchResult[index].location,
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
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
