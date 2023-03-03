import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'screens/main_screen.dart';
import 'screens/list_detail_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

import 'package:lab3/service/auth_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('localstorage');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        initialRoute: RegistrationPage.routeName,
        routes: {
          '/': (context) => MainScreen(),
          ListDetailScreen.routeName: (ctx) => ListDetailScreen(),
          LoginPage.routeName: (ctx) => LoginPage(),
          RegistrationPage.routeName: (ctx) => const RegistrationPage(),
        }
      // A widget which will be started on application startup
    );
  }
}
