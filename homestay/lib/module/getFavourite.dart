// import 'package:home_stay/pages/description.dart';

class getFavourite {
  late int id;
  late String name;
  late String description;
  late String created_at;
  late String location;
  late int price;
  late String website;
  late String image_url;
  late String culture_type;
  late String toilet_type;
  late String bed_type;
  late String cooling_soln;
  late String house_type;
  late int no_of_available_rooms;
  late String near_dest;
  late String owner_name;
  late String owner_phone;
  late String owner_email;
  late String image1;
  late String image2;
  late String image3;
  late String latitude;
  late String longitude;

  getFavourite(
    id, 
    name, 
    description, 
    created_at, 
    location, 
    price, 
    website, 
    image_url, 
    culture_type, 
    toilet_type, 
    bed_type, 
    cooling_soln,
    house_type,
    no_of_available_rooms,
    near_dest,
    owner_name,
    owner_phone,
    owner_email,
    image1,
    image2,
    image3,
    latitude,
    longitude
    )
    {
      this.id = id;
      this.name = name;
      this.description = description;
      this.created_at = created_at;
      this.location = location;
      this.price = price;
      this.website = website;
      this.image_url = image_url;
      this.culture_type = culture_type;
      this.toilet_type = toilet_type;
      this.bed_type = bed_type;
      this.cooling_soln = cooling_soln;
      this.house_type = house_type;
      this.no_of_available_rooms = no_of_available_rooms;
      this.near_dest = near_dest;
      this.owner_name = owner_name;
      this.owner_phone = owner_phone;
      this.owner_email = owner_email;
      this.image1 = image1;
      this.image2 = image2;
      this.image3 = image3;
      this.latitude = latitude;
      this. longitude = longitude;

    }
}