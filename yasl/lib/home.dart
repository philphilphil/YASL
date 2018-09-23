import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {


  TabController _tabController;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       appBar: new AppBar(
         title: new Text("YASL"),
         elevation: 0.7,
         bottom: new TabBar(
           controller: _tabController,
           indicatorColor: Colors.teal[700],
           tabs: <Widget> [
             new Tab(text: "Shopping list",),
             new Tab(text: "Recepies")
           ]
         ),
       ),
       body: new Container(),
    );
  }
}