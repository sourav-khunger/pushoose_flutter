import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants.dart';

import 'apiManager.dart';
import 'Model/Product.dart';
import 'Model/item_card.dart';

// Widget _itemBuilder(BuildContext context, int index) {
//   if (productDetail.length == null) {
//     return Container(child: Center(child: Text("Loading...")));
//   } else
//     return InkWell(
//         child: new Card(
//           shape: RoundedRectangleBorder(
//             side: BorderSide(color: Colors.white70, width: 1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: new InkResponse(
//             child: new GridTile(
//                 header: Padding(
//                   padding: const EdgeInsets.only(
//                     top: 6,
//                     left: 10,
//                     right: 10,
//                   ),
//                   child: new Text(
//                     productDetail[index].name,
//                     style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
//                     overflow: TextOverflow.clip,
//                     maxLines: 2,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 footer: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: new Text(
//                     productDetail[index].price + "€",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                     overflow: TextOverflow.clip,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(1.0),
//                         child: CarouselSlider(
//                           options: CarouselOptions(
//                             height: 340.0,
//                             aspectRatio: 16 / 9,
//                             viewportFraction: 1.0,
//                             enableInfiniteScroll: false,
//                           ),
//                           items: productDetail[index].images.map((i) {
//                             return Builder(
//                               builder: (BuildContext context) {
//                                 return Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                   // decoration: BoxDecoration(color: Colors.amber),
//                                   child: CachedNetworkImage(
//                                     fit: BoxFit.fill,
//                                     height: 300,
//                                     imageUrl: i.src,
//                                     placeholder: (context, url) =>
//                                         CircularProgressIndicator(),
//                                     errorWidget: (context, url, error) =>
//                                         Icon(Icons.error),
//                                   ),
//                                 );
//                               },
//                             );
//                           }).toList(),
//                         ),
//                         // child: CachedNetworkImage(
//                         //   fit: BoxFit.fill,
//                         //   height: 300,
//                         //   imageUrl: productDetail[index].images[0].src,
//                         //   placeholder: (context, url) =>
//                         //       CircularProgressIndicator(),
//                         //   errorWidget: (context, url, error) => Icon(Icons.error),
//                         // ),
//                       ),
//                     )
//                   ],
//                 )),
//             onLongPress: () {
//               _launchURL(context, productDetail[index].permalink);
//             },
//             onTap: () {
//               showGeneralDialog(
//                   context: context,
//                   barrierDismissible: true,
//                   barrierLabel:
//                   MaterialLocalizations.of(context).modalBarrierDismissLabel,
//                   barrierColor: Colors.black45,
//                   transitionDuration: const Duration(milliseconds: 200),
//                   pageBuilder: (BuildContext buildContext, Animation animation,
//                       Animation secondaryAnimation) {
//                     return Center(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width - 10,
//                         height: MediaQuery.of(context).size.height - 30,
//                         padding: EdgeInsets.all(20),
//                         alignment: Alignment.center,
//                         color: Colors.black87,
//                         child: Column(
//                           children: [
//                             Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         top: 10, left: 300, right: 0, bottom: 15),
//                                     child: RaisedButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: IconButton(
//                                           icon: Icon(
//                                             Icons.close,
//                                             color: Colors.white,
//                                           ),
//                                           onPressed: null),
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                 ]),
//                             CarouselSlider(
//                               options: CarouselOptions(
//                                 height: 550.0,
//                                 // enlargeCenterPage: true,
//                                 enableInfiniteScroll: false,
//                                 viewportFraction: 1.0,
//                               ),
//                               items: productDetail[index].images.map((i) {
//                                 return Builder(
//                                   builder: (BuildContext context) {
//                                     return Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       margin:
//                                       EdgeInsets.symmetric(horizontal: 5.0),
//                                       // decoration:
//                                       //     BoxDecoration(color: Colors.amber),
//                                       child: CachedNetworkImage(
//                                         // fit: BoxFit.fill,
//                                         width: 400,
//                                         imageUrl: i.src,
//                                         placeholder: (context, url) =>
//                                             CircularProgressIndicator(),
//                                         errorWidget: (context, url, error) =>
//                                             Icon(Icons.error),
//                                       ),
//                                     );
//                                   },
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   });
//             },
//           ),
//         ));
// }

// class Body extends StatelessWidget {
  // var productDetail = new List<Product>();

  // void getProducts() async {
  //   // ApiManager.getData()
  //   //     .then((value) => setState(() => {this.product = value}));
  //   ApiManager.getAllProducts().then((value) {
  //     setState(() {
  //       this.productDetail = value;
  //     });
  //   });
  // }
  //
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getProducts();
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return
  //     Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
  //         child: Text(
  //           "Women",
  //           style: Theme.of(context)
  //               .textTheme
  //               .headline5
  //               .copyWith(fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
  //           child: GridView.builder(
  //               itemCount: productDetail.length,
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: 2,
  //                 mainAxisSpacing: kDefaultPaddin,
  //                 crossAxisSpacing: kDefaultPaddin,
  //                 childAspectRatio: 0.75,
  //               ),
  //               itemBuilder: (context, index) => ItemCard(
  //                     product: productDetail[index],
  //                     press: (){
  //
  //                     }
  //                   )),
  //         ),
  //       ),
  //     ],
  //   );
  // }
// }
