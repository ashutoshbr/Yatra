class addBooking {
  late String date;
  late int no_of_days;
  late int homestay_id;
  late int no_of_rooms;

  addBooking(
    date,
    no_of_days,
    homestay_id,
    no_of_rooms
  ) 
  {
    this.date = date;
    this.no_of_days = no_of_days;
    this.homestay_id = homestay_id;
    this.no_of_rooms = no_of_rooms;
  }
}