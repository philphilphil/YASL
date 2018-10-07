import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  int _id;
  String colorCode;
  int rank;
  String name;
  bool isActive;

  Category(this.name, this.colorCode);

  Category.map(dynamic obj) {
    this.name = obj["name"];
    this.colorCode = obj["colorCode"];
    this._id = obj["id"];
    this.rank = obj["rank"];
    this.isActive = obj["isActive"] == 1;
  }

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["colorCode"] = colorCode;
    map["rank"] = rank;
    map["isActive"] = isActive == true ? 1 : 0;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Category.fromMap(Map<String, dynamic> obj) {
    this.name = obj["name"];
    this.colorCode = obj["colorCode"];
    this._id = obj["id"];
    this.rank = obj["rank"];
    this.isActive = obj["isActive"] == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
