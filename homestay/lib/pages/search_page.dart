import "package:flutter/material.dart";
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "../module/homedata.dart";

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
    try {
      var response = await Dio().get(url , options: 
        Options( headers: {
            'Authorization': "Bearer ${token}",
      }));

      print(response.data);
      // List<homedata> searchResult = [];
      // for (var i in )
    }
    catch(e) {
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search List"),
      ),
      // body: FutureBuilder(builder: builder)
    );
  }
}

