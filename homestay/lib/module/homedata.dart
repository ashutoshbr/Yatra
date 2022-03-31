class nearDestination {
  late String destination1;
  late String destination2;
  late String destination3;
  late String destination4;
  late String destination5;

  nearDestination(
      destination1, destination2, destination3, destination4, destination5) {
    this.destination1 = destination1;
    this.destination2 = destination2;
    this.destination3 = destination3;
    this.destination4 = destination4;
    this.destination5 = destination5;
  }
}

class homedata {
  late String homestay_name;
  late String homestay_photo;
  late String homestay_city;
  late String homestay_district;
  bool isFav = false;
  late String description;
  late String latrineType;
  late num price;
  late String cultureType;
  late String bedType;
  late String coolingSolution;
  late String houseType;
  late num id;
  late List<String> nearDestination;

  homedata(
      homestay_name,
      homestay_photo,
      homestay_city,
      homestay_district,
      isFav,
      description,
      latrineType,
      price,
      cultureType,
      bedType,
      coolingSolution,
      houseType,
      id,
      nearDestination) {
    this.homestay_name = homestay_name;
    this.homestay_photo = homestay_photo;
    this.homestay_city = homestay_city;
    this.homestay_district = homestay_district;
    this.isFav = isFav;
    this.description = description;
    this.latrineType = latrineType;
    this.price = price;
    this.cultureType = cultureType;
    this.bedType = bedType;
    this.coolingSolution = coolingSolution;
    this.houseType = houseType;
    this.id = id;
    this.nearDestination = nearDestination;
  }
}
