// import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:test_flutter_app/home.dart';
import 'dart:convert';
import 'Model/response.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Splash Screen",
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          primaryTextTheme:
          TextTheme(headline6: TextStyle(color: Colors.white))),
      home: SplashScreen(),
      routes: {'home': (context) => Home()},
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() {
    Timer(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacementNamed('home');
    });
  }


  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
        child: Center(
            child: Image.asset(
              "assets/logo.png",
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .4,
            )),
      ),

      // backgroundColor:,
    );
  }
}
