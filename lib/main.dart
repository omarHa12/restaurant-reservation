// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:resrev/screens/home_screen.dart';
import 'package:resrev/screens/login_screen.dart';
import 'package:resrev/screens/register_screen.dart';
import 'package:resrev/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Restaurant Reservation",
      initialRoute: Splash.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        Splash.id: (context) => Splash(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage()
      },
      // home: splash(),
    );
  }
}