import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/app_colors.dart';

class showAddTaskBottomSheet extends StatefulWidget {

  @override
  State<showAddTaskBottomSheet> createState() => _showAddTaskBottomSheetState();
}

class _showAddTaskBottomSheetState extends State<showAddTaskBottomSheet> {
  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add New Task", style: Theme.of(context).textTheme.bodyMedium
              !.copyWith(color: Colors.black),),
            SizedBox(
                height: 25,
              ),
            TextFormField(
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
            SizedBox(
              height: 15,
            ),
            TextFormField(
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
            SizedBox(
              height: 15,
            ),
            Container(
              width:double.infinity ,
              child: Text("Select Date"
                ,textAlign: TextAlign.start
                ,style: Theme.of(context).textTheme.bodySmall
              !.copyWith(
                color: Colors.black
              ),),
            ),
            InkWell(
              onTap: (){
                chooseDate(context);
              },
                child: Text("12/12/2012", textAlign: TextAlign.center,)),
            Container(
              width: MediaQuery.of(context).size.width*.5,
                child: ElevatedButton(
                    onPressed: (){
                      if (formKey.currentState!.validate()){

                      }
                    },
                    child: Text("Add Task")))
          ],
        ),
      ),
    );
  }

  chooseDate(BuildContext context){
    showDatePicker(
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
    );
  }
}
