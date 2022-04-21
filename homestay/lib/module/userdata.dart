class userdata {
  late String email;
  late String password;
  late String country;
  late String fullname;
  late String username;

  userdata(
    email, 
    password,
    country, 
    fullname, 
    username
  ) 
  {
    this.email = email;
    this.password = password;
    this.country = country;
    this.fullname = fullname;
    this.username = username;
  }
  Map toJson() => {
    'email' : email,
    'password': password,
    'country': country,
    'fullname': fullname,
    'username': username,
  };
}