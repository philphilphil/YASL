import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  String _name;
  String _dateCreated;
  int _id;
  int _recepieId;
  bool done = false;
  String _doneDate;
  String _category;

  ListItem(this._name, this._dateCreated);

  ListItem.map(dynamic obj) {
    this._name = obj["name"];
    this._dateCreated = obj["dateCreated"];
    this._id = obj["id"];
    this.done = obj["done"] == 1;
  }

  String get name => _name;
  String get category => _category;
 // bool get done => _done;
  String get dateCreated => _dateCreated;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["dateCreated"] = _dateCreated;
    map["done"] = done == true ? 1 : 0;
    if (_id != null) {
      map["id"] = _id;
    }
    

    return map;
  }

  ListItem.fromMap(Map<String, dynamic> map) {
    this._name = map["name"];
    this._dateCreated = map["dateCreated"];
    this._id = map["id"];
    this.done = map["done"] == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _name,
            style: new TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          )
        ],
      ),
    );
  }
}
