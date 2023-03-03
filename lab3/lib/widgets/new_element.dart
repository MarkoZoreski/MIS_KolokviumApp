import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:intl/intl.dart';
import '../model/list_item.dart';

class NewElement extends StatefulWidget {
  final Function addNewItemToList;
  NewElement(this.addNewItemToList);

  @override
  _NewElementState createState() => _NewElementState();
}

class _NewElementState extends State<NewElement> {
  final _formKey = GlobalKey<FormState>();
  final _subject_nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final subject_name = _subject_nameController.text;

    if (subject_name.isEmpty) {
      return;
    }

    final item = ListItem(
      id: nanoid(5),
      subject_name: subject_name,
      date: _selectedDate,
    );
    widget.addNewItemToList(item);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((pickedTime) {
        if (pickedTime == null) {
          return;
        }
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _subject_nameController,
              decoration: InputDecoration(
                labelText: "subject name",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "subject_name is required";
                }
                return null;
              },
            ),
            TextButton(
              onPressed: _presentDatePicker,
              child: Text(
                'Pick Date and Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}