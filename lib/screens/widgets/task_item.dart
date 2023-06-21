import 'package:flutter/material.dart';
import 'package:to_do/shared/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
      child: Card(
        elevation: 12,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.transparent,
          )

        ),
        child: Row(

          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
              height: 80,
              width: 5,
              decoration:  BoxDecoration(
                color: darkPurple2,
                borderRadius: BorderRadius.circular(4)
              ) ,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Task Title",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black)),
                SizedBox(height: 12,),
                Text("Task Discription",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10,color: Colors.black54),)
              ],
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.symmetric(horizontal: 18,vertical: 3),
                decoration: BoxDecoration(
                  color: darkPurple2,
                  borderRadius: BorderRadius.circular(12)

                ),


                child: Icon((Icons.done),color: Colors.white,size: 23,))

          ],
        ),
      ),
    );
  }
}
