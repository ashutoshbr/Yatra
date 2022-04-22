class Logindetails {
  final String email;
  final String password;

  Logindetails({required this.email, required this.password});

  Map toJson() => {
        'email': email,
        'password': password,
      };
}
