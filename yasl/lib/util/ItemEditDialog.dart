import 'package:flutter/material.dart';

class ItemEditDialog extends StatelessWidget {
  var nameCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameCtrl.text = "asd";
    return new SimpleDialog(
      title: const Text("Edit"),
      contentPadding: EdgeInsets.all(15.0),
      children: <Widget>[
        new TextField(
          controller: nameCtrl,
          decoration: InputDecoration(labelText: 'Item Name'),
        ),
        new TextField(
          controller: nameCtrl,
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
                  //_handleSubmit(_textEditingController.text);
                },
                child: Text("Save")),
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel"))
          ],
        )
      ],
    );
  }
}
