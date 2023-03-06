import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'list_item.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;
  @HiveField(2)
  List<ListItem> userItems = [];

  User({required this.username, required this.password });

}