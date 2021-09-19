// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:resrev/screens/login_screen.dart';
import 'package:resrev/constants.dart';



class Splash extends StatefulWidget {

static const id = "SplashScreen";

  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> {

  @override
  void initState(){
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      Navigator.pushNamed(context, LoginPage.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors:
                const [kSplashFirstColor,
                  kSplashSecondColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Center(
          child: Image.asset(
              'assets/images/'),
        ),
      ),
    );
  }
}
