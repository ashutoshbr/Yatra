import 'dart:ffi';

class homedata {
  late int id;
  late String homestay_name;
  late String image_url;
  late String location;
  late String created_at;
  late String description;
  late String toilet_type;
  late int price;
  late String culture_type;
  late String bed_type;
  late String cooling_soln;
  late String house_type;
  late String website;
  late String near_destinations;
  late int no_of_available_rooms;
  late String owner_name;
  late String owner_phone;
  late String owner_email;
  late String image1;
  late String image2;
  late String image3;
  late String latitude;
  late String longitude;
  

  homedata(
      id,
      homestay_name,
      image_url,
      location,
      created_at,
      description,
      toilet_type,
      price,
      culture_type,
      bed_type,
      cooling_soln,
      house_type,
      website,
      near_destinations,
      no_of_available_rooms,
      owner_name,
      owner_phone,
      owner_email,
      image1,
      image2,
      image3,
      latitude,
      longitude
      ) {
    this.id = id;
    this.homestay_name = homestay_name;
    this.image_url = image_url;
    this.location = location;
    this.created_at = created_at;
    this.description = description;
    this.toilet_type = toilet_type;
    this.price = price;
    this.culture_type = culture_type;
    this.bed_type = bed_type;
    this.cooling_soln = cooling_soln;
    this.house_type = house_type;
    this.website = website;
    this.near_destinations = near_destinations;
    this.no_of_available_rooms = no_of_available_rooms;
    this.owner_name = owner_name;
    this.owner_phone = owner_phone;
    this.owner_email = owner_email;
    this.image1 = image1;
    this.image2 = image2;
    this.image3 = image3;
    this.latitude = latitude;
    this.longitude = longitude;

  }
}