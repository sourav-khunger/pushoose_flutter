import 'package:flutter/material.dart';
import 'package:test_flutter_app/constants.dart';

import 'apiManager.dart';
import 'Model/Product.dart';
import 'Model/item_card.dart';

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
