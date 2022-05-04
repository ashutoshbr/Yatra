import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class reservation extends StatefulWidget {
  late String imageLink;
  late num no_of_available_rooms;
  late String homestay_name;

  reservation(imageLink, no_of_available_rooms, homestay_name) {
    this.imageLink = imageLink;
    this.no_of_available_rooms = no_of_available_rooms;
    this.homestay_name = homestay_name;
  }

  @override
  State<reservation> createState() => _reservationState();
}

class _reservationState extends State<reservation> {
  final durationController = TextEditingController();
  final roomsController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  DateTime? arrivalDate;
  String time = '';

  @override
  void showAlertDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Reservation ',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text(
            "Click Ok to reserve. Contact homestay within 3 days. \nClick anywhere outside the box to cancel",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    widget.no_of_available_rooms =
                        widget.no_of_available_rooms -
                            num.parse(roomsController.text);
                  });
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MyHomePage(),
                  //   ),
                  //   (Route<dynamic> route) => false,
                  // );
                  Navigator.pop(
                    context,
                  );
                },
                child:
                    Text('OK', style: Theme.of(context).textTheme.bodyText2)),
          ],
        ),
      );
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Reservation'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.3,
                // width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imageLink),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.homestay_name,
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Form(
                key: _key,
                child: Column(
                  children: [
                    Container(
                      child: Text('Number of available rooms:' +
                          '  ' +
                          widget.no_of_available_rooms.toString()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                      child: TextFormField(
                        controller: durationController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          labelText: 'Duration Of Stay',
                          hintText: 'How long will you stay',
                          hintStyle: GoogleFonts.lato(),
                          isDense: true,
                          contentPadding: EdgeInsets.all(20),
                        ),
                        // style: GoogleFonts.lato(
                        //   color: Theme.of(context).primaryColor,
                        // ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please! enter the duration';
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                      child: TextFormField(
                        controller: roomsController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          labelText: 'Number Of Rooms',
                          hintText: 'How many rooms do you need !!',
                          hintStyle: GoogleFonts.lato(),
                          isDense: true,
                          contentPadding: EdgeInsets.all(20),
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please! enter the desired Number of seats';
                          if (num.parse(value) > widget.no_of_available_rooms)
                            return 'Please check the available rooms';
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 85,
                      width: 500,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                        child: InkWell(
                          onTap: () async {
                            arrivalDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                            );
                            setState(() {
                              time = arrivalDate.toString().substring(0, 10);
                              // time = arrivalDate.toString();
                            });
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text('Choose a Date'),
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // show date
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Chosen Date : '),
                            Text(time),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Center(
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            child: Text(
                              'Reserve',
                              style: GoogleFonts.lato(fontSize: 20),
                            ),
                            onPressed: () {
                              if (_key.currentState!.validate() &&
                                  arrivalDate != null) {
                                _key.currentState!.save();
                                print(durationController.text);
                                print(roomsController.text);
                                showAlertDialog(context);
                              }
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
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        child: Text('*chosing a date is compulsary'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
