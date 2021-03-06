import 'package:flutter/material.dart';
import 'package:yasl/model/Listitem.dart';
import 'package:yasl/util/db_client.dart';
import 'package:yasl/util/ItemEditDialog.dart';

class ListItemCard extends StatefulWidget {
  ListItem item;
  Function callback;
  _ListItemCardState createState() => _ListItemCardState();

  ListItemCard(this.item, this.callback);
}

class _ListItemCardState extends State<ListItemCard> {
  var db = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    //return new Text("asd");

    return new ListTile(
      leading: new Container(
        height: 30.0,
        width: 3.0,
        color: Colors.green,
        margin: const EdgeInsets.only(left: 1.0, right: 1.0),
      ),
      title: new Text(widget.item.name + "  x 3"),
      trailing: new Checkbox(
        value: widget.item.done,
      ),
      isThreeLine: false,
      subtitle: widget.item.desc == null ? Text("") : Text(widget.item.desc),
      onTap: () {
        _updateItem(widget.item);
        widget.callback();
      },
      onLongPress: () {
        _showEditWidget(widget.item);
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
    );
  }

  //Dialog for editing item
  void _showEditWidget(ListItem item2) {
    var edit = new ItemEditDialog(item2.id, widget.callback);

    showDialog(
        context: context,
        builder: (_) {
          return edit;
        });
  }

  //Update item on db
  void _updateItem(ListItem item) async {
    item.done = !item.done;
    await db.updateItem(item);
    print("item saved");

    setState(() {});
  }
}
