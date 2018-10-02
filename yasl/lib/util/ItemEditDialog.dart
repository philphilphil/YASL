import 'package:flutter/material.dart';
import 'package:yasl/model/ListItem.dart';
import 'package:yasl/util/db_client.dart';

class ItemEditDialog extends StatefulWidget {
  var nameCtrl = new TextEditingController();
  ListItem item;
  int id;
  Function callback;
  ItemEditDialog(this.id, this.callback);

  _ItemEditDialogState createState() => _ItemEditDialogState();
}

class _ItemEditDialogState extends State<ItemEditDialog> {
  var nameCtrl = new TextEditingController();
  var descCtrl = new TextEditingController();
  var db = new DatabaseHelper();
  var item;

  void initState() {
    super.initState();

    db.getItem(widget.id).then((result) {
      setState(() {
        item = result;
      });
    });
  }

  _deleteItem() async {
    db.deleteItem(widget.id);
    widget.callback();
    Navigator.pop(context);
  }

  _saveItem() async {
    item.name = nameCtrl.text;
    item.desc = descCtrl.text;

    db.updateItem(item);
    widget.callback();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return new Container();
    }

    nameCtrl.text = item.name;
    descCtrl.text = item.desc;

    return new SimpleDialog(
      title: const Text("Edit"),
      contentPadding: EdgeInsets.all(15.0),
      children: <Widget>[
        new TextField(
          controller: nameCtrl,
          decoration: InputDecoration(labelText: 'Item Name'),
        ),
        new TextField(
          controller: descCtrl,
          decoration: InputDecoration(labelText: 'Description'),
        ),
        new Row(
          children: <Widget>[
            new CircleAvatar(backgroundColor: Colors.green),
            new Padding(padding: EdgeInsets.symmetric(horizontal: 20.0)),
            new Text("Amount: 1"),
            new IconButton(
              icon: new Icon(Icons.add),
              tooltip: 'Increase',
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.remove),
              tooltip: 'Decrease',
              onPressed: () {},
            )
          ],
        ),
        new Row(
          children: <Widget>[
            new FlatButton(
                onPressed: () {
                  _saveItem();
                },
                child: Text("Save")),
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            new FlatButton(
                onPressed: () {
                  _deleteItem();
                },
                child: Text("Delete"))
          ],
        )
      ],
    );
  }
}
