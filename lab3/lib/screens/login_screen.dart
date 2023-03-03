import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:lab3/screens/main_screen.dart';

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
      final box = await Hive.openBox('localstorage');
      final userPassword = box.get(username);
      if (userPassword == password) {
        // Navigate to the next page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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