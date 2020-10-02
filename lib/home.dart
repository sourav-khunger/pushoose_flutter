import 'dart:convert';

// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:test_flutter_app/Model/response.dart';

// import 'Model/response.dart';
import 'apiManager.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var product = new List<ProductCat>();

  void getData() async {
    // ApiManager.getData()
    //     .then((value) => setState(() => {this.product = value}));
    ApiManager.getData().then((value) {
      setState(() {
        this.product = value;
      });
    });
    // ApiManager.getData().then((response) {
    //   setState(() {
    //     product ;
    //   });
    // });
  }

  _buildExpandableContent(int i) {
    List<Widget> columnContent = [];

    for (int a = 0; a < product[i].children.length; a++) {
      columnContent.add(
        new ListTile(
          title: new Text(
            product[i].children[a].name,
            style: new TextStyle(fontSize: 16.0),
          ),
        ),
      );
    }

    return columnContent;
  }

  // _getUsers() {
  //   API.getUsers().then((response) {
  //     setState(() {
  //       Iterable list = json.decode(response.body);
  //       users = list.map((model) => User.fromJson(model)).toList();
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
            child: Text(
          "Home World",
          textAlign: TextAlign.center,
          textScaleFactor: 2,
        )),
        drawer: Drawer(
            child: SafeArea(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: product.length,
              itemBuilder: (context, i) {
                if (product[i].children.length > 0) {
                  // return ListView.builder(
                  //   itemCount: product[i].children.length,
                  //   itemBuilder: (context, a) {
                  return ExpansionTile(
                    title: Text(product[i].name),
                    children: <Widget>[
                      new Column(
                        children: _buildExpandableContent(i),
                      ),
                    ],
                  );
                  // },
                  // )
                } else {
                  return ListTile(
                    title: Text(product[i].name),
                  );
                }
                // return ListTile(
                //   trailing: Icon(Icons.arrow_right),
                //   onTap: () {
                //     if (product[i].children.length > 0) {
                //       ListView.builder(
                //         itemCount: product[i].children.length,
                //         itemBuilder: (context, a) {
                //           return ListTile(
                //             title: Text(product[i].children[a].name),
                //           );
                //         },
                //       );
                //     } else {}
                //   },
                //   title: Text(product[i].name),
                // );
              }),
        )

            // MultiLevelDrawer(
            //     header: Container(
            //       height: size.height * .25,
            //       child: Center(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Image.asset(
            //               "assets/dp_default.png",
            //               width: 100,
            //               height: 100,
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Text("Flutter Test")
            //           ],
            //         ),
            //       ),
            //     ),
            //     children: [
            //       // MLMenuItem(
            //       //     leading: Icon(Icons.home),
            //       //     content: Text(
            //       //       "Home",
            //       //       // textAlign: TextAlign.center,
            //       //     ),
            //       //     onClick: () {
            //       //       Navigator.of(context).pop();
            //       //     }),
            //       // MLMenuItem(
            //       //     leading: Icon(Icons.menu),
            //       //     trailing: Icon(Icons.arrow_right),
            //       //     subMenuItems: [
            //       //       MLSubmenu(
            //       //           submenuContent: Text('Submenu 1'),
            //       //           onClick: () {
            //       //             Navigator.of(context).pop();
            //       //           }),
            //       //       MLSubmenu(
            //       //           submenuContent: Text('Submenu 2'),
            //       //           onClick: () {
            //       //             Navigator.of(context).pop();
            //       //           }),
            //       //       MLSubmenu(
            //       //           submenuContent: Text('Submenu 3'),
            //       //           onClick: () {
            //       //             Navigator.of(context).pop();
            //       //           }),
            //       //     ],
            //       //     content: Text(
            //       //       "SubMenu",
            //       //       // textAlign: TextAlign.center,
            //       //     ),
            //       //     onClick: () {}),
            //       // MLMenuItem(
            //       //     leading: Icon(Icons.notifications),
            //       //     content: Text(
            //       //       "Notification",
            //       //       // textAlign: TextAlign.center,
            //       //     ),
            //       //     onClick: () {
            //       //       Navigator.of(context).pop();
            //       //     }),
            //     ]
            // )
            ),
        appBar: AppBar(
            title: Text(
          "Home",
          textAlign: TextAlign.center,
        )));
  }
}
