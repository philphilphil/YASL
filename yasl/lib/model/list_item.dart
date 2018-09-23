import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  String _name;
  String _dateCreated;
  int _id;
  int _recepieId;
  bool _done;
  String _doneDate;

  ListItem(this._name, this._dateCreated);

  ListItem.map(dynamic obj) {
    this._name = obj["name"];
    this._dateCreated = obj["dateCreated"];
    this._id = obj["id"];
  }

  String get name => _name;
  String get dateCreated => _dateCreated;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["dateCreated"] = _dateCreated;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  ListItem.fromMap(Map<String, dynamic> map) {
    this._name = map["name"];
    this._dateCreated = map["dateCreated"];
    this._id = map["id"];
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
