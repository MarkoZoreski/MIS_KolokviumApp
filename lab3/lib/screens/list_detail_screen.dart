import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/list_item.dart';

class ListDetailScreen extends StatelessWidget {
  static const routeName = '/list_detail';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments as ListItem;
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(item.date);
    return Scaffold(
      appBar: AppBar(
        title: Text("details for exam " + item.subject_name),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey[400]!,
              width: 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subject: ${item.subject_name}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Date: ${DateFormat('dd/MM/yyyy kk:mm').format(item.date)}',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
