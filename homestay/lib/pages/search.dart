import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_page.dart';

class searchBar extends StatefulWidget {
  const searchBar({Key? key}) : super(key: key);

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  
  final searchController = TextEditingController();
  String? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              prefixIcon: Icon(Icons.search),
              labelText: 'Search by District',
              // hintText: 'username123@gmail.com',
              hintStyle: GoogleFonts.lato(
                color: Theme.of(context).primaryColor,
              ),
              isDense: true,
              contentPadding: EdgeInsets.all(10),
              // border: OutlineInputBorder(),
            ),
            style: GoogleFonts.lato(
              color: Theme.of(context).primaryColor,
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        searchList(searchController.text),
                )
              );
              if (searchController.text != 0) {
                print(searchController.text);
              } else {
                print('Typesomething');
              }
            },
            child: Text('Submit'))
      ],
    );
  }
}
