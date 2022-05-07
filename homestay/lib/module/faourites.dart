class AddFavourite {
  final int homestay_id;

  AddFavourite({required this.homestay_id});

  Map toJson() => {
    'homestay_id': homestay_id
  };
}