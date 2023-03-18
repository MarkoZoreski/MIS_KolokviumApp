import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab3/model/user.dart';
import 'package:lab3/screens/calendar_detail_screen.dart';
import 'package:lab3/screens/map_screen.dart';
import 'package:lab3/screens/user_markers.dart';

import 'model/list_item.dart';
import 'screens/main_screen.dart';
import 'screens/list_detail_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ListItemAdapter());
  await Hive.openBox('localstorage');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final box = Hive.box('localstorage');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
        title: 'Flutter Hello World',
        // Application theme data, you can set the colors for the application as
        // you want
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.red,
        ),
        initialRoute: box.get('currentUser')!=null? MainScreen.routeName : LoginPage.routeName,
        routes: {
          '/': (context) => MainScreen(),
          ListDetailScreen.routeName: (ctx) => ListDetailScreen(),
          LoginPage.routeName: (ctx) => LoginPage(),
          RegistrationPage.routeName: (ctx) => const RegistrationPage(),
          CalendarDetails.routeName: (ctx) => CalendarDetails(),
          MapScreen.routeName: (ctx) => MapScreen(),
          UserMarkers.routeName: (ctx) => UserMarkers(),
        }
      // A widget which will be started on application startup
    );
  }
}
