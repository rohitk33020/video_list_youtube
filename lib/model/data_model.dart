// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

List<DataModel> dataModelFromJson(String str) =>
    List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

String dataModelToJson(List<DataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataModel {
  DataModel({
    this.id,
    this.title,
    this.videoUrl,
    this.coverPicture,
  });

  int? id;
  String? title;
  String? videoUrl;
  String? coverPicture;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["id"],
        title: json["title"],
        videoUrl: json["videoUrl"],
        coverPicture: json["coverPicture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "videoUrl": videoUrl,
        "coverPicture": coverPicture,
      };
}
