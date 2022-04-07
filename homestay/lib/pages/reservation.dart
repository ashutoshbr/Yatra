import 'package:flutter/material.dart';
import '../module/homedata.dart';

class reservation extends StatefulWidget {
  late homedata reservationData;
  reservation(reservationData) {
    this.reservationData = reservationData;
  }

  @override
  State<reservation> createState() => _reservationState();
}

class _reservationState extends State<reservation> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
