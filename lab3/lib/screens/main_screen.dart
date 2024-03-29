import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hive/hive.dart';
import 'package:lab3/screens/user_markers.dart';
import 'package:latlong2/latlong.dart';

import '../model/list_item.dart';
import '../model/user.dart';
import '../widgets/new_element.dart';
import '../widgets/my_list_tile.dart';
import 'login_screen.dart';
import 'package:lab3/widgets/Calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


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
  Random random = Random();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
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
  void _showUserMarkers(BuildContext context) {
    List<Marker> _markers = [];
    for (var item in _userItems) {
      var marker = Marker(
        width: 100.0,
        height: 100.0,
        point: LatLng(item.latitude, item.longitude),
        builder: (ctx) => Container(
          child: Icon(Icons.location_pin, color: Colors.red, size: 50.0),
        ),
      );
      _markers.add(marker);
    }
    Navigator.of(context).pushNamed(
      UserMarkers.routeName,
      arguments: _markers,
    );
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
  Future<void> _scheduleNotification(ListItem item) async {
    //check if the event is in less than an hour
    if((item.date.difference(DateTime.now())).inMinutes<= 59){
      return;
    }
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    final notificationId = Random().nextInt(2147483647);

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        'Reminder: ${item.subject_name}',
        'You have an event in 1 hour',
        tz.TZDateTime.from(item.date.add(Duration(hours: -1)), tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }
  void _addNewItemToList(ListItem item) async{
    setState(() {
      _userItems.add(item);
      currentUser?.userItems = _userItems;
      currentUser?.save();
    });
    // Schedule a notification 1 hour before the event
    await _scheduleNotification(item);
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
      floatingActionButton: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'calendar',
                backgroundColor: Colors.blue,
                onPressed: () => _showCalendar(context),
                child: Icon(Icons.calendar_month),
              ),
              FloatingActionButton(
                heroTag: 'map',
                backgroundColor: Colors.blue,
                onPressed: () => _showUserMarkers(context),
                child: Icon(Icons.map),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


}
