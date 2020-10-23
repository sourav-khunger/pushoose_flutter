import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:test_flutter_app/Model/Product.dart';
import 'package:test_flutter_app/Model/translatedModel.dart';

import 'Model/response.dart';

const baseUrl = 'http://pushoose.com/product-category/';
const baseUrlWithCategory =
    'https://pushoose.com/wp-json/wc/v3/products?consumer_key='
    'ck_cd7b63547aa8643375892a34126967eb6dc205f3&'
    'consumer_secret=cs_84c7d606bcb1b28fe547bd011e6ae5609f18336a&'
    'per_page=100&'
    'category=';
const baseUrlWithAllProduct = 'https://pushoose.com/wp-json/wc/v3/products?'
    'consumer_key=ck_cd7b63547aa8643375892a34126967eb6dc205f3&'
    'consumer_secret=cs_84c7d606bcb1b28fe547bd011e6ae5609f18336a&'
    'per_page=100';
const translateUrl = 'http://mymemory.translated.net/api/get?q=';

class ApiManager {
  static Future<List<ProductCat>> getData() async {
    final response = await http.get(baseUrl);
// Map<String, dynamic> map = json.decode(response.body);
// List<dynamic> data = map["dataKey"];
// print(data[0]["name"]);
    ResponseM list = ResponseM.fromJson(json.decode(response.body));
    return list.productCat;
  }

  static Future<List<Product>> getProductByCategoryId(String id) async {
    final response = await http.get(baseUrlWithCategory + id);
// Map<String, dynamic> map = json.decode(response.body);
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Product.fromJson(job)).toList();
  }

  static Future<List<Product>> getAllProducts() async {
    final response = await http.get(baseUrlWithAllProduct);
    List jsonResponse = json.decode(response.body);
    // String list = json.decode(response.body).toString();
    print(jsonResponse.length);

    return jsonResponse.map((job) => new Product.fromJson(job)).toList();
  }

  static Future<TranslatedModel> getTranslated(
      String text, String language) async {
    final response = await http.get(
        'http://mymemory.translated.net/api/get?q=' +
            text +
            "&langpair=" +
            language);
    TranslatedModel jsonResponse = json.decode(response.body);
    // String list = json.decode(response.body).toString();
    // print(jsonResponse.length);

    // return jsonResponse
    //     .map((job) => new TranslatedModel.fromJson(job))
    //     .toList();
    return jsonResponse;
  }
}
