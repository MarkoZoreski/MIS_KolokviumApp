import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/list_item.dart';

class CalendarDetails extends StatelessWidget {
  static const routeName = '/exams_detail';

  const CalendarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ListItem> items =
    ModalRoute.of(context)?.settings.arguments as List<ListItem>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exams'),
      ),
      body: items.length == 0
          ? Center(child: Text('There are no scheduled exams for this day'))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text('Subject: ${item.subject_name}'),
              subtitle: Text('Date: ${DateFormat('dd/MM/yyyy kk:mm').format(item.date)}',),
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
