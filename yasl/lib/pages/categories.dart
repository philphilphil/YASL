import 'package:flutter/material.dart';
import 'package:yasl/model/Category.dart';
import 'package:yasl/util/Drawer.dart';
import 'package:yasl/util/db_client.dart';

class Categories extends StatefulWidget {
  List<Widget> catgegorieItems;
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var _switch = true;
  var _result;
  var db = new DatabaseHelper();
  List<Widget> catgegorieItems;

  @override
  void initState() {
    super.initState();
    _reloadList();
  }

  // reload data from db and set state
  void _reloadList() {
    print("load");
    _readItemsToList().then((result) {
        print("load2");
      BuildWidgets(result);
        print(result);
      setState(() {
        catgegorieItems = catgegorieItems;
      });
    });
  }

  //get data from db
  _readItemsToList() async {
    List items = await db.getAllCategories();
    print(items);
    List<Category> _itemList = <Category>[];
    items.forEach((item) {
      print(item.name);
      _itemList.add(Category.map(item));
    });
    return _itemList;
  }

  @override
  Widget build(BuildContext ctxt) {
    if (catgegorieItems == null) {
      return new Container();
    }
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Manage Categories"),
        ),
        drawer: new Drawerr(),
        body: new ReorderableListView(
          // header: Card(
          //   child: Text("Drag to reorder. Tap to rename."),
          // ),
          children: widget.catgegorieItems,
          onReorder: (int oldIndex, int newIndex) {},
        ));
  }

  void BuildWidgets(var result) {
    for (Category i in result) {
      catgegorieItems.add(new SwitchListTile(
        key: Key(i.id.toString()),
        title: Text(i.name),
        value: _switch,
        onChanged: (bool value) {
          setState(() {
            _switch = value;
          });
        },
        secondary: new Container(
          height: 30.0,
          width: 30.0,
          color: Colors.green,
          margin: const EdgeInsets.only(left: 1.0, right: 1.0),
        ),
      ));
    }
  }
}
