import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:test_flutter_app/Model/Product.dart';
import 'package:test_flutter_app/Model/response.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter_app/Model/translatedModel.dart';
import 'package:translator/translator.dart';

import 'apiManager.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var product = new List<ProductCat>();
  TranslatedModel translatedResponse;
  bool isLoadingPage;

  /*
  var productNaviEN = new List<String>();
  var productNaviFN = new List<String>();
  var productNaviENProduct = new List<String>();
  var productNaviFNProduct = new List<String>();*/
  var productDetail = new List<Product>();
  var _searchList = new List<Product>();
  final translator = GoogleTranslator();
  Icon actionIcon = new Icon(Icons.search, color: Colors.white);
  bool pressed = false;
  bool isEnglish = true;
  Widget appBarTitle = new Text("Pushoose");
  List<Images> myList = new List();
  bool _IsSearching;
  String _searchText = "";
  final TextEditingController _searchQuery = TextEditingController();
  String translated = "";
  bool isHigh = false;
  Future<String> _bar;
  bool isLoading;

  void getData() async {
    setState(() {
      isLoading = false;
    });
    // ApiManager.getData()
    //     .then((value) => setState(() => {this.product = value}));
    ApiManager.getData().then((value) {
      setState(() {
        this.product = value;
        setState(() {
          isLoading = false;
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

  void getProducts() async {
    setState(() {
      isLoadingPage = true;
    });
    ApiManager.getAllProducts().then((value) {
      setState(() {
        this.productDetail = value;
        _searchList = new List<Product>();

        // productNaviENProduct = new List();
        // productNaviFNProduct = new List();
        _searchList = productDetail;
        setState(() {
          isLoadingPage = false;
        });
        // for (int i = 0; i < _searchList.length; i++) {
        //   translateToEnglishProduct(_searchList[i].name);
        //   translateToFrenchProduct(_searchList[i].name);
        // getTranslatedEN(_searchList[i].name, "fr|en");
        // getTranslatedFR(_searchList[i].name, "en|fr");
        // }
      });
    });
  }

/*  void showTranslation(String text) {
    if (pressed) {
      getTranslatedFR(text, "en|fr");
    } else {
      getTranslatedEN(text, "fr|en");
    }
  }*/

  // void getTranslatedEN(String text, String pressed) async {
  //   ApiManager.getTranslated(text, pressed).then((value) {
  //     setState(() {
  //       this.translatedResponse = value;
  //
  //       productNaviENProduct
  //           .add(translatedResponse.responseData.translatedText);
  //     });
  //   });
  // }
  //
  // void getTranslatedFR(String text, String pressed) async {
  //   ApiManager.getTranslated(text, pressed).then((value) {
  //     setState(() {
  //       this.translatedResponse = value;
  //       productNaviFNProduct
  //           .add(translatedResponse.responseData.translatedText);
  //     });
  //   });
  // }

  void getProductByCategoryId(String id) async {
    setState(() {
      isLoadingPage = true;
    });
    ApiManager.getProductByCategoryId(id).then((value) {
      setState(() {
        this.productDetail = value;
        _searchList = productDetail;

        setState(() {
          isLoadingPage = false;
        });
      });
    });
  }

  Future<String> translateToEnglish(String text) async {
    // String translate= await text.translate(to: 'pt')
    // Passing the translation to a variable
    var translation = await translator.translate(text, from: 'fr', to: 'en');
    print("translation: $translation");
    // translated = "";
    // productNaviEN.add(translation.text);
    return translation.text;
  }

  Future<String> translateToFrench(String text) async {
    // String translate= await text.translate(to: 'pt')
    // Passing the translation to a variable
    var translation = await translator.translate(text, from: 'en', to: 'fr');
    print("translation: $translation");
    // translated = "";
    // productNaviFN.add(translation.text);

    return translation.text;
  }

  Future<String> translateToEnglishProduct(String text) async {
    // String translate= await text.translate(to: 'pt')
    // Passing the translation to a variable
    var translation = await translator.translate(text, from: 'fr', to: 'en');
    print("translation: $translation");
    // translated = "";
    // productNaviENProduct.add(translation.text);
    return translation.text;
  }

  Future<String> translateToFrenchProduct(String text) async {
    // String translate= await text.translate(to: 'pt')
    // Passing the translation to a variable
    var translation = await translator.translate(text, from: 'en', to: 'fr');
    print("translation: $translation");
    // translated = "";
    // productNaviFNProduct.add(translation.text);

    return translation.text;
  }

  init() {
    getProducts();
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
          _buildSearchList();
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
          _buildSearchList();
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoadingPage = true;
    getData();
    init();
    // _bar = translateToEnglish(text);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        "Pushoose",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  List<Product> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchList = productDetail;
    } else {
      _searchList = productDetail
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
      print('${_searchList.length}');
      return _searchList;
    }
  }

  String str = 'French';

// app bar

  Widget _itemBuilder(BuildContext context, int index) {
    if (productDetail.length == null) {
      return Container(child: Center(child: Text("Loading...")));
    } else
      return InkWell(
          child: new Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: new InkResponse(
          child: new GridTile(
              header: Padding(
                padding: const EdgeInsets.only(
                  top: 6,
                  left: 10,
                  right: 10,
                ),
                child: new Text(
                  productDetail[index].name,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  productDetail[index].price + "€",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 340.0,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                        ),
                        items: productDetail[index].images.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                // decoration: BoxDecoration(color: Colors.amber),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  height: 300,
                                  imageUrl: i.src,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      // child: CachedNetworkImage(
                      //   fit: BoxFit.fill,
                      //   height: 300,
                      //   imageUrl: productDetail[index].images[0].src,
                      //   placeholder: (context, url) =>
                      //       CircularProgressIndicator(),
                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                      // ),
                    ),
                  )
                ],
              )),
          onLongPress: () {
            _launchURL(context, productDetail[index].permalink);
          },
          onTap: () {
            showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel:
                    MaterialLocalizations.of(context).modalBarrierDismissLabel,
                barrierColor: Colors.black45,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (BuildContext buildContext, Animation animation,
                    Animation secondaryAnimation) {
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      height: MediaQuery.of(context).size.height - 30,
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      color: Colors.black87,
                      child: Column(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 300, right: 0, bottom: 15),
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        onPressed: null),
                                    color: Colors.black87,
                                  ),
                                ),
                              ]),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 550.0,
                              // enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              viewportFraction: 1.0,
                            ),
                            items: productDetail[index].images.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    // decoration:
                                    //     BoxDecoration(color: Colors.amber),
                                    child: CachedNetworkImage(
                                      // fit: BoxFit.fill,
                                      width: 400,
                                      imageUrl: i.src,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: buildBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isLoadingPage
              ? Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 10),
                  child: Center(
                      child: Column(
                    children: [
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.deepOrange),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('Loading please wait...'))
                    ],
                  )))
              : Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: GridView.builder(
                        itemCount: _searchList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: kDefaultPaddin,
                          crossAxisSpacing: kDefaultPaddin,
                          childAspectRatio: .85,
                        ),
                        itemBuilder: (context, index) {
                          if (_searchList.length == 0 ||
                              _searchList.length == null) {
                            return Center(
                              child: Text(
                                "List is Empty...",
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            );
                          } else {
                            return new GridItem(_searchList[index]);
                          }
                        }),
                  ),
                ),
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 10),
                    child: Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.deepOrange),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text('Loading please wait...'))
                      ],
                    )))
                : ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 1000),
                    child: Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: product.length,
                            itemBuilder: (context, i) {
                              if (product[i].children.length > 0) {
                                // return ListView.builder(
                                //   itemCount: product[i].children.length,
                                //   itemBuilder: (context, a) {

                                return expansionTileMethod(i);
                              } else {
                                return Column(
                                  children: [
                                    /*FutureBuilder(
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  return*/
                                    ListTile(
                                      title: Text(product[i].name),
                                      onTap: () {
                                        setState(() {
                                          // print(translateToEnglish(
                                          //         product[i].name)
                                          //     .toString());
                                          getProductByCategoryId(
                                              product[i].termId.toString());
                                          _buildSearchList();
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    )
                                    // },
                                    // future: translateToEnglish(product[i].name),
                                    // ),
                                  ],
                                );
                              }
                            })),
                  )
            // Container(
            //   height: 55.0,
            //   child: DrawerHeader(
            //       child: GestureDetector(
            //         onTap: () {
            //           // print("onTap called.");
            //           setState(() {
            //             pressed = !pressed;
            //             if (!pressed) {
            //             } else {}
            //           });
            //         },
            //         child: pressed
            //             ? Text(
            //                 "French",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(color: Colors.white, fontSize: 18),
            //               )
            //             : Text(
            //                 "English",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(color: Colors.white, fontSize: 18),
            //               ),
            //       ),
            //       decoration: BoxDecoration(color: Colors.deepOrange),
            //       margin: EdgeInsets.all(0.0),
            //       padding: EdgeInsets.all(15.0)),
            // ),
          ],
        ),
      ),
      // AppBar(
      //   backgroundColor: Colors.deepOrange,
      //   iconTheme: new IconThemeData(color: Colors.white),
      //   centerTitle: true,
      //   title: appBarTitle,
      //   actions: <Widget>[
      //     new IconButton(
      //       icon: actionIcon,
      //       onPressed: () {
      //         setState(() {
      //           if (this.actionIcon.icon == Icons.search) {
      //             this.actionIcon = new Icon(Icons.close);
      //             this.appBarTitle = new TextField(
      //               style: new TextStyle(
      //                 color: Colors.white,
      //               ),
      //               decoration: new InputDecoration(
      //                   prefixIcon:
      //                       new Icon(Icons.search, color: Colors.white),
      //                   hintText: "Search...",
      //                   hintStyle: new TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 20,
      //                   )),
      //             );
      //           } else {
      //             this.actionIcon = new Icon(Icons.search);
      //             this.appBarTitle = new Text("Pushoose");
      //           }
      //         });
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(
      //         Icons.filter_list,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {},
      //     ),
      //   ],
      // )
    );
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        iconTheme: new IconThemeData(color: Colors.white),
        title: GestureDetector(
          child: appBarTitle,
          onTap: () {
            setState(() {
              getProducts();
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = TextField(
                    controller: _searchQuery,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: "   Search here..",
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 18)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (isHigh) {
                  isHigh = false;
                  _searchList.sort((a, b) =>
                      double.parse(a.price).compareTo(double.parse(b.price)));

                  Fluttertoast.showToast(
                      msg: "Filter is set to low to high price!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  isHigh = true;
                  _searchList.sort((a, b) =>
                      double.parse(b.price).compareTo(double.parse(a.price)));
                  Fluttertoast.showToast(
                      msg: "Filter is set to High to low price!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              });
            },
          ),
        ]);
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: new CustomTabsOption(
          toolbarColor: Colors.deepOrange,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn()
          // or user defined animation.
          /* animation: new CustomTabsAnimation(
          startEnter: 'slide_up',
          startExit: 'android:anim/fade_out',
          endEnter: 'android:anim/fade_in',
          endExit: 'slide_down',
        )*/
          ,
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  expansionTileMethod(int i) {
    print(product[i].children.length.toString() + " length");
    for (int a = 0; a < product[i].children.length; a++) {
      // print("expansion if $i   $a");

      if (product[i].children[a].children.length > 0) {
        // print("IFFF " + product[i].children[a].name);
        return ExpansionTile(
            title: Text(product[i].name),
            children: <Widget>[new Column(children: expansionList(i, a))]);
      } else {
        // print("ELSE " + product[i].name);
        if (product[i].children.length > 0) {
          return ExpansionTile(
            title: Text(product[i].name),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(i),
              ),
            ],
          );
        } else {
          return ListTile(
            title: Text(product[i].name),
            onTap: () {
              setState(() {
                getProductByCategoryId(product[i].termId.toString());
                Navigator.of(context).pop();
              });
            },
          );
        }
      }
    }
  }

  _buildExpandableContent(int i) {
    List<Widget> columnContent = [];

    for (int a = 0; a < product[i].children.length; a++) {
      columnContent.add(
        new ListTile(
          title: new Text(
            product[i].children[a].name,
            style: new TextStyle(fontSize: 15.0),
          ),
          onTap: () {
            setState(() {
              getProductByCategoryId(product[i].termId.toString());
              Navigator.of(context).pop();
              // Fluttertoast.showToast(
              //     msg: "List ",
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 1,
              //     backgroundColor: Colors.black87,
              //     textColor: Colors.white,
              //     fontSize: 16.0);
            });
          },
        ),
      );
    }

    return columnContent;
  }

  expansionList(int i, int z) {
    List<Widget> columnContent = [];
    for (int a = 0; a < product[i].children[z].children.length; a++) {
      print(product[i].children[a].name);
      if (product[i].children[a].children.length > 0) {
        columnContent.add(
          new ExpansionTile(
            title: Text(product[i].children[a].name),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent2(i, a),
              ),
            ],
          ),
        );
      } else {
        columnContent.add(new ListTile(
          title: Text(product[i].children[a].name),
          onTap: () {
            setState(() {
              getProductByCategoryId(product[i].children[a].termId.toString());
              Navigator.of(context).pop();
            });
          },
        ));
      }
    }

    return columnContent;
  }

  _buildExpandableContent2(int i, int z) {
    List<Widget> columnContent = [];

    for (int a = 0; a < product[i].children[z].children.length; a++) {
      // print("EXPANDABLE " + product[i].children[z].children[a].name);
      columnContent.add(
        new ListTile(
          onTap: () {
            setState(() {
              getProductByCategoryId(
                  product[i].children[z].children[a].termId.toString());
              Navigator.of(context).pop();
            });
          },
          title: new Text(
            product[i].children[z].children[a].name,
            style: new TextStyle(fontSize: 15.0),
          ),
        ),
      );
    }

    return columnContent;
  }
}

class GridItem extends StatelessWidget {
  final Product model;
  var productNaviENProduct;

  var productNaviFNProduct;

  bool pressed;

  GridItem(this.model);

  Widget build(BuildContext context) {
    return InkWell(
            child: new Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: new InkResponse(
        child: new GridTile(
            header: Padding(
                padding: const EdgeInsets.only(
                  top: 6,
                  left: 10,
                  right: 10,
                ),
                child: new Text(
                  model.name,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                )),
            footer: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: new Text(
                      model.price + "€",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90, bottom: 5),
                  child: RaisedButton(
                    onPressed: () {
                      _launchURL(context, model.permalink);
                    },
                    child: Text(
                      "View Details",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.0),
                    child: GestureDetector(
                      onTap: () {
                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context)
                                .modalBarrierDismissLabel,
                            barrierColor: Colors.black45,
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder: (BuildContext buildContext,
                                Animation animation,
                                Animation secondaryAnimation) {
                              return Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 10,
                                  height:
                                      MediaQuery.of(context).size.height - 30,
                                  padding: EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  color: Colors.black87,
                                  child: Column(
                                    children: [
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  left: 300,
                                                  right: 0,
                                                  bottom: 15),
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: null),
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ]),
                                      CarouselSlider(
                                        options: CarouselOptions(
                                          height: 550.0,
                                          // enlargeCenterPage: true,
                                          enableInfiniteScroll: false,
                                          viewportFraction: 1.0,
                                        ),
                                        items: model.images.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5.0),
                                                // decoration:
                                                //     BoxDecoration(color: Colors.amber),
                                                child: CachedNetworkImage(
                                                  // fit: BoxFit.fill,
                                                  width: 400,
                                                  imageUrl: i.src,
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 340.0,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                        ),
                        items: model.images.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                // decoration: BoxDecoration(color: Colors.amber),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  height: 300,
                                  imageUrl: i.src,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    // child: CachedNetworkImage(
                    //   fit: BoxFit.fill,
                    //   height: 300,
                    //   imageUrl: productDetail[index].images[0].src,
                    //   placeholder: (context, url) =>
                    //       CircularProgressIndicator(),
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    // ),
                  ),
                )
              ],
            )),
        onLongPress: () {
          _launchURL(context, model.permalink);
        },
        onTap: () {},
      ),
    ))
        /*Card(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
      elevation: 10.0,
      child: InkWell(
        splashColor: Colors.orange,
        onTap: () {
          print(model.id);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child:CarouselSlider(
                options: CarouselOptions(
                  height: 550.0,
                  // enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                ),
                items: model.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                        EdgeInsets.symmetric(horizontal: 5.0),
                        // decoration:
                        //     BoxDecoration(color: Colors.amber),
                        child: CachedNetworkImage(
                          // fit: BoxFit.fill,
                          width: 400,
                          imageUrl: i.src,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.model.name,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                    maxLines: 1,
                  ),
                  SizedBox(height: 0.0),
                  Text(
                    model.name,
                    style: TextStyle(fontFamily: 'Roboto'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )*/
        ;
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: new CustomTabsOption(
          toolbarColor: Colors.deepOrange,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn()
          // or user defined animation.
          /* animation: new CustomTabsAnimation(
          startEnter: 'slide_up',
          startExit: 'android:anim/fade_out',
          endEnter: 'android:anim/fade_in',
          endExit: 'slide_down',
        )*/
          ,
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
