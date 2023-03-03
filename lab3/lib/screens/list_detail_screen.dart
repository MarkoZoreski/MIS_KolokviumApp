import 'package:flutter/material.dart';

import '../model/list_item.dart';

class ListDetailScreen extends StatelessWidget {
  static const routeName = '/list_detail';
  //final ListItem item;
  //ListDetailScreen(this.item);

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments as ListItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.subject_name),
      ),
      body: Column(children: [
        Text(item.subject_name),
        Text(item.date.toString()),
      ]),
    );
  }
}
