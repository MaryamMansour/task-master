import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/network/firebase/firebase_functions.dart';

import '../../shared/styles/app_colors.dart';

class showAddTaskBottomSheet extends StatefulWidget {

  @override
  State<showAddTaskBottomSheet> createState() => _showAddTaskBottomSheetState();
}

class _showAddTaskBottomSheetState extends State<showAddTaskBottomSheet> {
  var formKey= GlobalKey<FormState>();
  var selected=DateUtils.dateOnly(DateTime.now());
  @override

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();



  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Form( //text form field should be inside Form
        key: formKey, //Form widget should be stateful
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add New Task", style: Theme.of(context).textTheme.bodyMedium
              !.copyWith(color: Colors.black),),
            const SizedBox(
                height: 25,
              ),
            TextFormField(
              textInputAction: TextInputAction.next,//ممكن اعمله  new line
              controller: titleController,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "please enter task title";
                    }return null;
                },
        decoration: InputDecoration(
            errorStyle: Theme.of(context).textTheme.bodySmall!.
            copyWith(color: Colors.red, fontSize:12 ),
              label: Text("Task Title"),
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: primaryColor
                )
              )
              ),
        ),
            const SizedBox(
              height: 15,
            ),

            TextFormField(
              maxLines: 3,
              controller: descriptionController,
              validator: (value){
                if (value == null || value.isEmpty) {
                  return "please enter task description";
                }else if( value.length <10)
                  { return "enter more than 10 characters";}
                return null;
              },
              decoration: InputDecoration(
                  label: Text("Task Description"),
                  errorStyle: Theme.of(context).textTheme.bodySmall!.
                  copyWith(color: Colors.red, fontSize:12 ),
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: primaryColor
                      )
                  )
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width:double.infinity ,
              child: Text("Select Date"
                ,textAlign: TextAlign.start
                ,style: Theme.of(context).textTheme.bodyMedium
              !.copyWith(
                color: Colors.black
              ),),
            ),
            InkWell(
              onTap: (){
                chooseDate(context);
              },
                child: Text(selected.toString().substring(0,10),
                  textAlign: TextAlign.center,)),
            Container(
              width: MediaQuery.of(context).size.width*.5,
                child: ElevatedButton(
                    onPressed: (){
                      if (formKey.currentState!.validate()){
                        TaskModel task= TaskModel(
                            title: titleController.text,
                            date: selected.microsecondsSinceEpoch,
                            description: descriptionController.text,
                            status: false);
                        FireBaseFunctions.addTaskToFirestore(task).then((value) =>
                        Navigator.pop(context));
                      }
                    },
                    child: Text("Add Task")))
          ],
        ),
      ),
    );
  }
  chooseDate(BuildContext context)async{
    DateTime? selectedDate= await showDatePicker(
        context: context,
        builder: (context, child) => Theme(data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.deepPurple,
            onPrimary: Colors.white24,
            onSurface: Colors.black26
          )
        ) , child: child!),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365),
        ),
    ); if(selectedDate!=null){
      selected =DateUtils.dateOnly(selectedDate);
      setState(() {
        
      });
    }
  }
}
