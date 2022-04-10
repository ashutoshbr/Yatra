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
  late num no_of_available_rooms;
  late List<String> photo_collection;

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
      nearDestination,
      no_of_available_rooms,
      photo_collection) {
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
    this.no_of_available_rooms = no_of_available_rooms;
    this.photo_collection = photo_collection;
  }
}
