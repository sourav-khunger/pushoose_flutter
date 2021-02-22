// import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:test_flutter_app/home.dart';
import 'dart:convert';
import 'Model/response.dart';
import 'apiManager.dart';

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
      // routes: {'home': (context) => Home()},
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
      ],
      localizationsDelegates: [
        // AppLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var productCat = new List<ProductCat>();

  void startTimer() {
    Timer(Duration(seconds: 2), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(this.productCat)));

      // Navigator.of(context).pushReplacementNamed('home');
    });
  }
  void getData() async {
    setState(() {
      // isLoading = false;
    });
    // ApiManager.getData()
    //     .then((value) => setState(() => {this.product = value}));
    ApiManager.getData().then((value) {
      setState(() {
        this.productCat = value;
        setState(() {
          startTimer();

          // isLoading = false;
        });
        /*  productNaviEN = new List();
        productNaviFN = new List();
        for (int i = 0; i < product.length; i++) {
          translateToEnglish(product[i].name);
          translateToFrench(product[i].name);
        }*/
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
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
          width: MediaQuery.of(context).size.width * .4,
        )),
      ),

      // backgroundColor:,
    );
  }
}
