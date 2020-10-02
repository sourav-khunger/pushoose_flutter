// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

ResponseM responseFromJson(String str) => ResponseM.fromJson(json.decode(str));

String responseToJson(ResponseM data) => json.encode(data.toJson());

class ResponseM {
  ResponseM({
    this.productCat,
  });

  List<ProductCat> productCat;

  factory ResponseM.fromJson(Map<String, dynamic> json) => ResponseM(
    productCat: List<ProductCat>.from(json["product_cat"].map((x) => ProductCat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_cat": List<dynamic>.from(productCat.map((x) => x.toJson())),
  };
}

@JsonSerializable(nullable: false)
class ProductCat {
  ProductCat({
    this.termId,
    this.name,
    this.slug,
    this.termGroup,
    this.termTaxonomyId,
    this.taxonomy,
    this.description,
    this.parent,
    this.count,
    this.filter,
    this.children,
  });

  int termId;
  String name;
  String slug;
  int termGroup;
  int termTaxonomyId;
  Taxonomy taxonomy;
  String description;
  int parent;
  int count;
  Filter filter;
  List<ProductCat> children;

  factory ProductCat.fromJson(Map<String, dynamic> json) => ProductCat(
    termId: json["term_id"],

    name: json["name"],
    slug: json["slug"],
    termGroup: json["term_group"],
    termTaxonomyId: json["term_taxonomy_id"],
    taxonomy: taxonomyValues.map[json["taxonomy"]],
    description: json["description"],
    parent: json["parent"],
    count: json["count"],
    filter: filterValues.map[json["filter"]],
    children: List<ProductCat>.from(json["children"].map((x) => ProductCat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "term_id": termId,
    "name": name,
    "slug": slug,
    "term_group": termGroup,
    "term_taxonomy_id": termTaxonomyId,
    "taxonomy": taxonomyValues.reverse[taxonomy],
    "description": description,
    "parent": parent,
    "count": count,
    "filter": filterValues.reverse[filter],
    "children": List<dynamic>.from(children.map((x) => x.toJson())),
  };
}

enum Filter { RAW }

final filterValues = EnumValues({
  "raw": Filter.RAW
});

enum Taxonomy { PRODUCT_CAT }

final taxonomyValues = EnumValues({
  "product_cat": Taxonomy.PRODUCT_CAT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
