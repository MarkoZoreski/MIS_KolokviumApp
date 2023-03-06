import 'package:hive/hive.dart';
part 'list_item.g.dart';

@HiveType(typeId: 1)
class ListItem extends HiveObject{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String subject_name;
  @HiveField(2)
  final DateTime date;

  ListItem({
    required this.id,
    required this.subject_name,
    required this.date,
  });
}
