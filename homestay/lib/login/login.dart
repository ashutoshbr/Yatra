import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './signup.dart';
import '../main.dart';
import '../module/logindetails.dart';

class logIn extends StatefulWidget {
  const logIn({Key? key}) : super(key: key);

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  Future<bool> postLogindata(Logindetails user) async {
    final storage = new FlutterSecureStorage();
    String jsonUser = jsonEncode(user);
    print(jsonUser);
    // var token = await storage.read('token');
    // try {
    //   var response =
    //       await Dio().post('http://10.0.2.2:8000/user/login', data: jsonUser,options: Options(
    //         headers: {
    //           'Authorization': "Bearer ${token}",
    //         }
    //       ));
    //   storage.write('token',value:response.data.)
    try {
      var response = await Dio().post('http://10.0.2.2:8000/user/login', data: jsonUser);
      print(response);
      await storage.write(key: "token", value: response.data["access_token"]);
      return true;
    } catch (e) {
      return false;
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  int borderRadius = 11;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                          0, MediaQuery.of(context).size.height * 0.025, 0, 0),
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

                    // ----------->container for the password<---------------//

                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.025, 0, 0),
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

              // ---------------->login button<------------------------------------//

              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                margin: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.025, 0, 0),
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.2,
                    0,
                    MediaQuery.of(context).size.width * 0.2,
                    0),
                child: ElevatedButton(
                  child: Text(
                    'Login',
                    style: GoogleFonts.lato(),
                  ),
                  onPressed: () async {
                    Logindetails user1 = Logindetails(
                        email: emailController.text,
                        password: passwordController.text);
                    bool loggedIn = await postLogindata(user1);
                    print(loggedIn);
                    if (loggedIn) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Incorrect Credentials")));
                    }

                    // }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),

              // ----------------->forgot password<-------------------------//

              Container(
                margin: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.025, 0, 0),
                child: TextButton(
                  onPressed: () {
                    //forgot password screen yo baki xa//
                  },
                  child: Text(
                    'Forgot Password',
                    style: GoogleFonts.lato(
                      color: Color(0xff533e85),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              // ----------------->sign up way<-----------------------------//

              Container(
                margin: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.025, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'No account yet?',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    TextButton(
                      child: Text(
                        'Sign up',
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
                            builder: (context) => signUp(),
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
