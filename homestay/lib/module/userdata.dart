class Userdata {
  final String email;
  final String password;
  final String country;
  final String fullname;
  final String username;

  Userdata({
    required this.email,
    required this.password,
    required this.country,
    required this.fullname,
    required this.username,
  });
  Map toJson() => {
        'email': email,
        'password': password,
        'country': country,
        'fullname': fullname,
        'username': username,
      };
}
