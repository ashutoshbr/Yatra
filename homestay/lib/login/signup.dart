import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_stay/login/login.dart';
import 'package:home_stay/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../pages/profile.dart';
import '../module/userdata.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  Future postUserdata(userdata user) async {
    String jsonUser = jsonEncode(user);
    print(jsonUser);
    var response = await http.post(Uri.http('10.0.2.2:8000', 'user'), body: jsonUser);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final countryController = TextEditingController();
  final fullnameController = TextEditingController();
  bool isPasswordVisible = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    countryController.dispose();
    fullnameController.dispose();
    super.dispose();
  }

  void showAlertDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              'Password doesn\'t match',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            content: Text(
              "The re-entered password doesn/'t match with the password",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => signUp(),
                    ),
                  );
                },
                child: Text('Try Again !',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ]),
      );

  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.08,
            MediaQuery.of(context).size.height * 0.1,
            MediaQuery.of(context).size.width * 0.08,
            MediaQuery.of(context).size.height * 0.05,
          ),
          child: ListView(
            children: [
              // -------------->container for app logo in log in page<-------------//

              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    (MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height) *
                        0.02,
                    MediaQuery.of(context).size.width * 0.05,
                    0),
                padding: EdgeInsets.all(10),
                height: (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icon.png'),
                    // fit: BoxFit.fill,
                  ),
                ),
              ),

              // ------------->container for email<-------------------------//

              Form(
                key: _key,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.015, 0, 0),
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          prefixIcon: Icon(Icons.mail),
                          labelText: 'Email',
                          // hintText: 'username123@gmail.com',
                          hintStyle: GoogleFonts.lato(
                            color: Theme.of(context).primaryColor,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: GoogleFonts.lato(
                          color: Theme.of(context).primaryColor,
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Field is Empty';
                          String pattern = r'\w+@\w+\.\w+';
                          if (!RegExp(pattern).hasMatch(value))
                            return 'Invalid E-mail Address format';
                          String capital = r'^(?=.*[A-Z])';
                          if (RegExp(capital).hasMatch(value))
                            return 'Email Address mustn\'t contain Uppercase';
                          return null;
                        },
                      ),
                    ),

                    // ---------------------->username<--------------------------------//

                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.001, 0, 0),
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Username',
                          // hintText: 'username123@gmail.com',
                          hintStyle: GoogleFonts.lato(
                            color: Theme.of(context).primaryColor,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: GoogleFonts.lato(
                          color: Theme.of(context).primaryColor,
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Username can\'t be Empty';
                          return null;
                        },
                      ),
                    ),

                    // ---------------------->Full Name<--------------------------------//
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.001, 0, 0),
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: fullnameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Full Name',
                          hintStyle: GoogleFonts.lato(
                            color: Theme.of(context).primaryColor,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: GoogleFonts.lato(
                          color: Theme.of(context).primaryColor,
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    // ---------------------->Country<--------------------------------//
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.001, 0, 0),
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: countryController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          prefixIcon: Icon(Icons.flag),
                          labelText: 'Country',
                          hintStyle: GoogleFonts.lato(
                            color: Theme.of(context).primaryColor,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: GoogleFonts.lato(
                          color: Theme.of(context).primaryColor,
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    // ----------->container for the password<---------------//

                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.001, 0, 0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          prefixIcon: Icon(Icons.key),
                          suffixIcon: IconButton(
                            icon: isPasswordVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(
                                  () => isPasswordVisible = !isPasswordVisible);
                            },
                          ),
                          labelText: 'Password',
                          hintStyle: GoogleFonts.lato(
                            color: Theme.of(context).primaryColor,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: GoogleFonts.lato(
                          color: Theme.of(context).primaryColor,
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Password can\'t be Empty';
                          String pattern =
                              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{5,}$';
                          if (!RegExp(pattern).hasMatch(value))
                            return '''Password must have at least 5 characters,
                            one uupercase letter and one digit ''';
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // ---------------->Sign up button<------------------------------------//

              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                margin: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.01, 0, 0),
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.2,
                    0,
                    MediaQuery.of(context).size.width * 0.2,
                    0),
                child: ElevatedButton(
                  child: Text(
                    'SignUp',
                    style: GoogleFonts.lato(),
                  ),
                  onPressed: () async {
                    userdata user1 = userdata(emailController.text, countryController.text, fullnameController.text, usernameController.text, passwordController.text);
                    postUserdata(user1);
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => logIn(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                    // ? Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MyHomePage(),
                    //     ),
                    //   )
                    // : showAlertDialog(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),

              // ----------------->sign up way<-----------------------------//

              Container(
                margin: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.015, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    TextButton(
                      child: Text(
                        'Log In',
                        style: GoogleFonts.lato(
                          color: Color(0xff533e85),
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => logIn(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
