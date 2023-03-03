import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;


import 'package:hive/hive.dart';
import 'package:lab3/Domain/login_response.dart';

import '../model/user.dart';

class AuthService {
  static final AuthService _instance = AuthService._privateConstructor();

  AuthService._privateConstructor();
  AuthService();

  static AuthService get instance => _instance;

  Future<LoginResponse> register(String email, String password) async {
    final data = {'email': email, 'password': password};
    final url = Uri.parse('${Constants.apiUrl}/auth/register');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      final box = Hive.box('localstorage');
      await box.put('token', token);

      return const LoginResponse(success: true, message: "Sucess!");
    } else {
      return const LoginResponse(
          success: false, message: "Something went wrong!");
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    final url = Uri.parse('${Constants.apiUrl}/auth/login');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      final box = Hive.box('localstorage');
      await box.put('token', token);

      return const LoginResponse(success: true, message: "Sucess!");
    } else {
      return const LoginResponse(
          success: false, message: "Something went wrong!");
    }
  }

  Future<LoginResponse> qrLogin(String hash) async {
    final data = {'hash': hash};
    final url = Uri.parse('${Constants.apiUrl}/auth/qr-login');
    final box = Hive.box('localstorage');
    final token = await box.get('token');
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
      return const LoginResponse(success: true, message: "Sucess!");
    } else {
      return const LoginResponse(
          success: false, message: "Something went wrong!");
    }
  }

  Future<void> logout() async {
    final box = Hive.box('localstorage');
    await box.delete('token');
  }

  bool userIsLoggedIn() {
    final box = Hive.box('localstorage');

    return box.get('token') != null;
  }
}
class Constants {
  static const String apiUrl = "http://192.168.1.108:8080/api";
}