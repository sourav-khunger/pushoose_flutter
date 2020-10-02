import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'Model/response.dart';

const baseUrl = 'http://pushoose.com/product-category/';

class ApiManager {
  static Future<List<ProductCat>> getData() async {
    final response = await http.get(baseUrl);
    Map<String, dynamic> map = json.decode(response.body);
    // List<dynamic> data = map["dataKey"];
    // print(data[0]["name"]);
    ResponseM list = ResponseM.fromJson(json.decode(response.body));
    return list.productCat;
  }
}
