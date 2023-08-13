import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/network/firebase/firebase_functions.dart';
import 'package:to_do/screens/widgets/task_item.dart';

import '../shared/styles/app_colors.dart';

class TasksScreen extends StatefulWidget {

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime date =  DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10,),
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: darkPurple,
          selectedTextColor: Colors.white,
          height: 120,
          onDateChange: (newdate) {
            // New date selected
            setState(() {
              date = newdate;
            });
          },
        ),
        SizedBox(height: 20,),
        
        StreamBuilder(
            stream: FireBaseFunctions.getTasksFromFirestore(date),
            builder: (context, snapshot) {

              if(snapshot.connectionState== ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator());
                }
              
              if (snapshot.hasError)
                {
                  return Column(
                    children: [
                      Text("Something is wrong!"),
                      ElevatedButton(onPressed: (){}, child: Text("Try Again"))
                    ],
                  );
                }

              List<TaskModel> tasks=
                  snapshot.data?.docs.map((e) => e.data()).toList()??[];
              
              return Expanded(
                child: ListView.builder(itemBuilder: (context, index) => 
                    TaskItem(tasks[index]),
                  itemCount: tasks.length,),
              );
            },
        )
      ],
    );
  }
}












