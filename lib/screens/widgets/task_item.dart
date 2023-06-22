import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/network/firebase/firebase_functions.dart';
import 'package:to_do/screens/edit_screen.dart';
import 'package:to_do/shared/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;
  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 12,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.transparent,
          )),
      child: Slidable(
        startActionPane: ActionPane(motion: StretchMotion(),
          extentRatio: 0.6,
          children: [
            SlidableAction(
              // An action can be bigger than the others.

              flex: 1,
              onPressed: (context){
                FireBaseFunctions.deleteTask(task.id);
              },
              autoClose: true,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            SlidableAction(
              // An action can be bigger than the others
              onPressed: (context){
                Navigator.pushNamed(context, EditScreen.routeName,
                arguments: task);
              },
              autoClose: true,
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: BorderRadius.only(

              ),
            )
          ],),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),

          child: Row(

            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                height: 80,
                width: 5,
                decoration:  BoxDecoration(
                  color:  task.status? Colors.green: darkPurple2,
                  borderRadius: BorderRadius.circular(4)
                ) ,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,style: Theme.of(context)
                      .textTheme.bodyLarge!.copyWith
                    (color: task.status?Colors.green: Colors.black)),
                  SizedBox(height: 12,),
                  Text(task.description,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10,color: Colors.black54),)
                ],
              ),
              Spacer(),
              task.status?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Done!", style: Theme.of(context)
                    .textTheme.bodyLarge!.copyWith(
                    color: Colors.green
                ),),
              ):
              InkWell(
                onTap: (){
                  task.status=true;
                  FireBaseFunctions.updateTask(task.id, task);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 18,vertical: 3),
                    decoration: BoxDecoration(
                      color: darkPurple2,
                      borderRadius: BorderRadius.circular(12)

                    ),


                    child: Icon((Icons.done),color: Colors.white,size: 23,)),
              )

            ],
          ),
        ),
      ),
    );
  }
}
