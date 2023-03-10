import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:lab3/screens/main_screen.dart';
import 'package:lab3/screens/register_screen.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitForm() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (_formKey.currentState!.validate()) {
      final box = Hive.box('localstorage');
      print(box.length);
      final user = box.get(username);
      if (user == null) {
        // Navigate to the next page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User does not exist!'
              'Click the button in the corner to register')),
        );
      }
      else if(user.password == password){
        box.put('currentUser',user.username);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
          IconButton(
          icon: Icon(Icons.app_registration),
          onPressed: () async {
        Navigator.of(context).pushReplacementNamed(RegistrationPage.routeName);
        },
          ),
          ]
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Username is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Log in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}