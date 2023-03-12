import 'package:flutter/material.dart';
import 'package:lab3/screens/calendar_detail_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive/hive.dart';

import 'package:lab3/model/list_item.dart';
import 'package:lab3/model/user.dart';
import 'package:lab3/screens/list_detail_screen.dart';
import 'package:lab3/widgets/utils.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final box = Hive.box('localstorage');
  User? currentUser;
  final currentUsername = '';
  List<ListItem> _userItems = [];

  @override
  void initState() {
    super.initState();
    final currentUsername = box.get('currentUser');
    if (currentUsername != null) {
      currentUser = box.get(currentUsername);
      _userItems = currentUser!.userItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raspored'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          // Get all events for the selected day
          List<ListItem> events = _userItems.where((event) => isSameDay(event.date, selectedDay)).toList();

          // Navigate to the list detail screen, passing in the list of events
          Navigator.pushNamed(context, CalendarDetails.routeName, arguments: events);

          // Update the selected day and focused day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        eventLoader: (day) {
          final items = _userItems
              .where((listItem) => isSameDay(listItem.date, day))
              .toList();

          if (items.isEmpty) {
            return [];
          }

          return items.map((listItem) => listItem).toList();
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
