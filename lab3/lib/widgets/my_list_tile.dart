import 'package:flutter/material.dart';

import '../screens/list_detail_screen.dart';
import '../model/list_item.dart';
import 'package:intl/intl.dart';

class MyListTile extends StatelessWidget {
  final ListItem item;
  final Function func;

  void _showDetail(BuildContext context) {
    Navigator.of(context).pushNamed(
      ListDetailScreen.routeName,
      arguments: item,
    );
  }

  MyListTile(this.item, this.func);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      child: ListTile(
        title: Text(item.subject_name),
        subtitle: Text(DateFormat('dd/MM/yyyy kk:mm').format(item.date)),
        onTap: () => _showDetail(context),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => func(context, item.id),
        ),
      ),
    );
  }
}
