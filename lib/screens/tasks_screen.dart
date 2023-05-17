import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.black,
          selectedTextColor: Colors.white,
          height: 120,
          onDateChange: (newdate) {
            // New date selected
            setState(() {
              date = newdate;
            });
          },
        ),
      ],
    );
  }
}