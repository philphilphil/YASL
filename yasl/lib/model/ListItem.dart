import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  int _id;
  String name;
  String desc;
  int amount;
  String _dateCreated;
  bool done = false;
  int category;

  ListItem(this.name, this._dateCreated);

  ListItem.map(dynamic obj) {
    this.name = obj["name"];
    this._dateCreated = obj["dateCreated"];
    this._id = obj["id"];
    this.done = obj["done"] == 1;
    this.desc = obj["desc"];
    this.category = obj["category"];
    this.amount = obj["amount"];
  }

  String get dateCreated => _dateCreated;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["dateCreated"] = _dateCreated;
    map["done"] = done == true ? 1 : 0;
    if (_id != null) {
      map["id"] = _id;
    }
    map["desc"] = this.desc;
    map["category"] = this.category;
    map["amount"] = this.amount;
    return map;
  }

  ListItem.fromMap(Map<String, dynamic> map) {
    this.name = map["name"];
    this._dateCreated = map["dateCreated"];
    this._id = map["id"];
    this.done = map["done"] == 1;
    this.desc = map["desc"];
    this.category = map["category"];
    this.amount = map["amount"];
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
