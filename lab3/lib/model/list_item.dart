import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ListItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String subject_name;
  @HiveField(3)
  final DateTime date;

  ListItem({
    required this.id,
    required this.subject_name,
    required this.date,
  });
}
