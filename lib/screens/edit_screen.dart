import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/home_layout/home_layout.dart';
import 'package:to_do/screens/widgets/show_add_task_bottom_sheet.dart';

import '../models/task_model.dart';
import '../network/firebase/firebase_functions.dart';
import '../shared/styles/app_colors.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "EditScreen";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var selected=DateUtils.dateOnly(DateTime.now());


  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var args =ModalRoute.of(context)?.settings.arguments as TaskModel;
    titleController=TextEditingController(text: args.title);
    descriptionController = TextEditingController(text: args.description);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDo App",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, left: 10,right: 10,top: 50),//padding for Keyboard only from bottom
         // padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),

          child: Card(
          elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
        ),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text("Task Title", style: Theme.of(context).textTheme
                  .bodyLarge,),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                      controller: titleController,
                      textInputAction: TextInputAction.next,
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
                      )
                  ),
                ),
                SizedBox(height: 30,),
                Text("Task Discription", style: Theme.of(context).textTheme
                    .bodyLarge,),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller: descriptionController,
                    maxLines: 3,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          errorStyle: Theme.of(context).textTheme.bodySmall!.
                          copyWith(color: Colors.red, fontSize:12 ),
                          label: Text("Task Discription"),
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(
                                  color: primaryColor
                              )
                          )
                      )
                  ),
                ),
                SizedBox(height: 40,),
                InkWell(
                  onTap: (){
                  chooseDate(context);
                  },
                    child: Text(selected.toString().substring(0,10))),
                SizedBox(height: 15,),

                ElevatedButton(onPressed: (){

                TaskModel task= TaskModel(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                id: args.id,
                title: titleController.text,
                    date: selected.microsecondsSinceEpoch,
                    description: descriptionController.text,
                    status: false);

                  FireBaseFunctions.updateTask(args.id, task);


                }, child: Text("Edit")),
                SizedBox(height: 30,),


              ],
            ),
          ),
        ),
      ),
    );
  }



chooseDate(BuildContext context)async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    builder: (context, child) =>
        Theme(data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: Colors.deepPurple,
                onPrimary: Colors.white24,
                onSurface: Colors.black26
            )
        ), child: child!),
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365),
    ),
  );
  if (selectedDate != null) {
    selected = DateUtils.dateOnly(selectedDate);
    setState(() {

    });
  }
}
}