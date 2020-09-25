import 'package:flutter/material.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        body: Center(

        child: Text(
        "Home World",
        textAlign: TextAlign.center,
        textScaleFactor: 2,
    )),

    // decoration: BoxDecoration(
    //   gradient: LinearGradient(
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //       colors: [
    //         Color.fromRGBO(255, 65, 108, 1.0),
    //         Color.fromRGBO(255, 75, 43, 1.0),
    //       ]),
    // )),
    // body: Container(
    //   decoration: BoxDecoration(
    //     gradient: SweepGradient(colors: [
    //       Colors.pink,
    //       Colors.red,
    //       Colors.green,
    //       Colors.purple,
    //       Colors.teal
    //     ], stops: [
    //       0.8,
    //       0.96,
    //       0.74,
    //       0.22,
    //       0.85
    //     ], startAngle: 0.5, endAngle: 1),
    //   ),
    //   // Center(
    //   // child: Text(
    //   // "Home World",
    //   // textScaleFactor: 2,
    //   // )),
    // ),
    drawer: MultiLevelDrawer(
    header: Container(
    height: size.height * .25,
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Image.asset(
    "assets/dp_default.png",
    width: 100,
    height: 100,
    ),
    SizedBox(
    height: 10,
    ),
    Text("Flutter Test")
    ],
    ),
    ),
    ),
    children: [
    MLMenuItem(
    leading: Icon(Icons.home),
    content: Text(
    "Home",
    // textAlign: TextAlign.center,
    ),
    onClick: () {
    Navigator.of(context).pop();
    }),
    MLMenuItem(
    leading: Icon(Icons.menu),
    trailing: Icon(Icons.arrow_right),
    subMenuItems: [
    MLSubmenu(
    submenuContent: Text('Submenu 1'),
    onClick: () {
    Navigator.of(context).pop();
    }),
    MLSubmenu(
    submenuContent: Text('Submenu 2'),
    onClick: () {
    Navigator.of(context).pop();
    }),
    MLSubmenu(
    submenuContent: Text('Submenu 3'),
    onClick: () {
    Navigator.of(context).pop();
    }),
    ],
    content: Text(
    "SubMenu",
    // textAlign: TextAlign.center,
    ),
    onClick: () {}),
    MLMenuItem(
    leading: Icon(Icons.notifications),
    content: Text(
    "Notification",
    // textAlign: TextAlign.center,
    ),
    onClick: () {
    Navigator.of(context).pop();
    }),
    ]),
    appBar: AppBar(
    title: Text(
    "Home",
    textAlign: TextAlign.
    center
    ,
    )
    )
    );
  }
}
