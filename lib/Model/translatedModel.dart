// To parse this JSON data, do
//
//     final translatedModel = translatedModelFromJson(jsonString);

import 'dart:convert';

TranslatedModel translatedModelFromJson(String str) => TranslatedModel.fromJson(json.decode(str));

String translatedModelToJson(TranslatedModel data) => json.encode(data.toJson());

class TranslatedModel {
  TranslatedModel({
    this.responseData,
    this.quotaFinished,
    this.mtLangSupported,
    this.responseDetails,
    this.responseStatus,
    this.responderId,
    this.exceptionCode,
    this.matches,
  });

  ResponseData responseData;
  bool quotaFinished;
  dynamic mtLangSupported;
  String responseDetails;
  int responseStatus;
  String responderId;
  dynamic exceptionCode;
  List<Match> matches;

  factory TranslatedModel.fromJson(Map<String, dynamic> json) => TranslatedModel(
    responseData: ResponseData.fromJson(json["responseData"]),
    quotaFinished: json["quotaFinished"],
    mtLangSupported: json["mtLangSupported"],
    responseDetails: json["responseDetails"],
    responseStatus: json["responseStatus"],
    responderId: json["responderId"],
    exceptionCode: json["exception_code"],
    matches: List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseData": responseData.toJson(),
    "quotaFinished": quotaFinished,
    "mtLangSupported": mtLangSupported,
    "responseDetails": responseDetails,
    "responseStatus": responseStatus,
    "responderId": responderId,
    "exception_code": exceptionCode,
    "matches": List<dynamic>.from(matches.map((x) => x.toJson())),
  };
}

class Match {
  Match({
    this.id,
    this.segment,
    this.translation,
    this.source,
    this.target,
    this.quality,
    this.reference,
    this.usageCount,
    this.subject,
    this.createdBy,
    this.lastUpdatedBy,
    this.createDate,
    this.lastUpdateDate,
    this.match,
  });

  String id;
  String segment;
  String translation;
  String source;
  String target;
  String quality;
  dynamic reference;
  int usageCount;
  String subject;
  String createdBy;
  String lastUpdatedBy;
  DateTime createDate;
  DateTime lastUpdateDate;
  double match;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
    id: json["id"],
    segment: json["segment"],
    translation: json["translation"],
    source: json["source"],
    target: json["target"],
    quality: json["quality"],
    reference: json["reference"],
    usageCount: json["usage-count"],
    subject: json["subject"],
    createdBy: json["created-by"],
    lastUpdatedBy: json["last-updated-by"],
    createDate: DateTime.parse(json["create-date"]),
    lastUpdateDate: DateTime.parse(json["last-update-date"]),
    match: json["match"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "segment": segment,
    "translation": translation,
    "source": source,
    "target": target,
    "quality": quality,
    "reference": reference,
    "usage-count": usageCount,
    "subject": subject,
    "created-by": createdBy,
    "last-updated-by": lastUpdatedBy,
    "create-date": createDate.toIso8601String(),
    "last-update-date": lastUpdateDate.toIso8601String(),
    "match": match,
  };
}

class ResponseData {
  ResponseData({
    this.translatedText,
    this.match,
  });

  String translatedText;
  double match;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    translatedText: json["translatedText"],
    match: json["match"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "translatedText": translatedText,
    "match": match,
  };
}
