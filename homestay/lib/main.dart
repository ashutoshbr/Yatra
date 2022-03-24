import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/favourites.dart';
import '../pages/profile.dart';
import '../pages/main_home.dart';
import '../onboarding/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './colors/colors.dart';
import './login/login.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen ${initScreen}');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Stay',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF533E85, color),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.lato(
            color: Color(
              0xff533e85,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: initScreen == 0 || initScreen == null ? "first" : "/",
      routes: {
        '/': (context) => logIn(),
        "first": (context) => Home(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final screens = [MainHome(), Favourites(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          /*this is used when type is fixed*/
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
              }),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              // backgroundColor: Colors.purple[300],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
              // backgroundColor: Colors.yellow, when the type is fixed background color is selected above
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              // backgroundColor: Colors.purple[300],
            )
          ]),
    );
  }
}
