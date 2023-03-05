import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/list_item.dart';
import '../model/user.dart';
import '../widgets/new_element.dart';
import '../widgets/my_list_tile.dart';
import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ListItem> _userItems = [
    ListItem(id: "T1", subject_name: "Kalkulus", date: DateTime.now()),
    ListItem(id: "T2", subject_name: "Verojatnost",date: DateTime.now()),
  ];


  void _addItemFunction(BuildContext ct) {
    //
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(onTap: () {
          }, child: NewElement(_addNewItemToList), behavior: HitTestBehavior.opaque);
        });
  }

  void _addNewItemToList(ListItem item) {
    setState(() {
      _userItems.add(item);
    });
  }

  void _deleteItem(BuildContext context, String id) {
    setState(() {
      _userItems.removeWhere((elem) => elem.id == id);
    });
  }

  Widget _createBody() {
    return Center(
      child: _userItems.isEmpty
          ? Text("No elements")
          : ListView.builder(
        itemBuilder: (ctx, index) {
          return MyListTile(
            _userItems[index],
            _deleteItem,
          );
        },
        itemCount: _userItems.length,
      ),
    );
  }

  PreferredSizeWidget _createAppBar() {
    return AppBar(
      // The title text which will be shown on the action bar
        title: Text("KolokviumiApp"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addItemFunction(context),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: _createBody(),
    );
  }
}
