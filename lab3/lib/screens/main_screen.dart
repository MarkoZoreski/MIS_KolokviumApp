import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/list_item.dart';
import '../model/user.dart';
import '../widgets/new_element.dart';
import '../widgets/my_list_tile.dart';
import 'login_screen.dart';
import 'package:lab3/widgets/Calendar.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final box = Hive.box('localstorage');
  User? currentUser;
  final currentUsername = '';
  List<ListItem> _userItems = [];

  @override
  void initState() {
    super.initState();
    final currentUsername = box.get('currentUser');
    if(currentUsername != null) {
      currentUser = box.get(currentUsername);
      _userItems = currentUser!.userItems;
    }
  }



  void _addItemFunction(BuildContext ct) {
    //
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(onTap: () {
          }, child: NewElement(_addNewItemToList), behavior: HitTestBehavior.opaque);
        });
  }
  void _showCalendar(BuildContext ct) {
    //
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(onTap: () {
          }, child: Calendar(),
              behavior: HitTestBehavior.opaque);
        });
  }

  void _addNewItemToList(ListItem item) {
    setState(() {
      _userItems.add(item);
      currentUser?.userItems = _userItems;
      currentUser?.save();
      //box.put(currentUser?.username, currentUser);
    });
  }

  void _deleteItem(BuildContext context, String id) {
    setState(() {
      _userItems.removeWhere((elem) => elem.id == id);
      currentUser?.userItems = _userItems;
      currentUser?.save();
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
              currentUser?.userItems = _userItems;
              currentUser?.save();
              _userItems = [];
              box.delete('currentUser');
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => _showCalendar(context),
        child: Icon(Icons.calendar_month),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
