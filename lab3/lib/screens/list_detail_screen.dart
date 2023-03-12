import 'package:flutter/material.dart';

import '../model/list_item.dart';

class ListDetailScreen extends StatelessWidget {
  static const routeName = '/list_detail';

  @override
  Widget build(BuildContext context) {
    final List<ListItem> items =
    ModalRoute.of(context)?.settings.arguments as List<ListItem>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(item.subject_name),
              subtitle: Text(item.date.toString()),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          );
        },
      ),
    );
  }
}
