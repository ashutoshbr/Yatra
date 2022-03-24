import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) *
                  0.063,
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.08,
                            0,
                            MediaQuery.of(context).size.width * 0.08,
                            (MediaQuery.of(context).size.height -
                                    AppBar().preferredSize.height) *
                                0.063),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: InkWell(
                          onTap: (() {
                            print('Pressed');
                          }),
                          child: Column(
                            children: [
                              // upper homestay holder
                              Container(
                                  height: (MediaQuery.of(context).size.height -
                                          AppBar().preferredSize.height) *
                                      0.05,
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.025,
                                      0,
                                      0,
                                      0),
                                  // color: Color(0xff533e85),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      child: Text('Favourite',
                                          style: GoogleFonts.lato(
                                              fontSize: 20,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xff533e85),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      topLeft: Radius.circular(5),
                                    ),
                                  )),
                              // image holder
                              Container(
                                  height: (MediaQuery.of(context).size.height -
                                          AppBar().preferredSize.height) *
                                      0.25,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage('assets/stayimage.png'),
                                    fit: BoxFit.fill,
                                  ))),
                              //lower address container
                              Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.025,
                                      0,
                                      0,
                                      0),
                                  height: (MediaQuery.of(context).size.height -
                                          AppBar().preferredSize.height) *
                                      0.05,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      child: Text('kathmandu',
                                          style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xff533e85),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                  )),
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
