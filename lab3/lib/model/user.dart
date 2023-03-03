import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;

  User({required this.email, required this.password});
}