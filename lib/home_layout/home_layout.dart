import 'package:flutter/material.dart';
import 'package:to_do/screens/setting_screen.dart';
import 'package:to_do/screens/tasks_screen.dart';

import '../screens/widgets/show_add_task_bottom_sheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "ToDo App",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showAddTaskBottomSheet();
        },
      child: Icon(Icons.add,size: 30,),
      shape: StadiumBorder(
       side: BorderSide(
         color:  Colors.white,
         width: 3
       )
      )
        ,),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: index,
          onTap: (value){
            index = value;
            setState(() {});
          },
          iconSize: 30,
          items: [
            BottomNavigationBarItem(icon:
             Icon(Icons.list),label: ""),
            BottomNavigationBarItem(icon:
            Icon(Icons.settings),label: "")
          ],
        ),
      ),
      body: tabs[index],

    );
  }
  List<Widget>tabs=[TasksScreen(),SettingsScreen()];

   showAddTaskBottomSheetf(){
    showModalBottomSheet(context: context,
      isScrollControlled: true,
      builder: (context){
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
          child: showAddTaskBottomSheet());
    },);
  }
}