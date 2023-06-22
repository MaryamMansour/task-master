import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../models/task_model.dart';

class FireBaseFunctions{


  // IT point on the collection
  static CollectionReference<TaskModel> getTaskCollection()
  {
    return FirebaseFirestore.instance.collection("Tasks")
        .withConverter<TaskModel>(
        fromFirestore: (snapshot,_) => TaskModel.fromJson(snapshot.data()!),
        toFirestore: (task,_) => task.toJson(),
    );
  }

  //Both are static bc
  // I want to call it by class directly

  static Future<void> addTaskToFirestore(TaskModel task){
    var collection = getTaskCollection();
    var docRef= collection.doc();
    task.id= docRef.id; //عشان التاسم ملهاش اي دي هاخدها من الدوك
    return docRef.set(task); // و باقي الحجات الفاضية هعملها سيت ب اللي عندي ف التاسك
  }


 static Stream<QuerySnapshot<TaskModel>> getTasksFromFirestore(DateTime date)
  {
    var collection = getTaskCollection();
    return collection
        .where("date", isEqualTo:DateUtils.dateOnly(date).microsecondsSinceEpoch)
        .snapshots();
  }
static Future<void> deleteTask(String id )
{
  return getTaskCollection().doc(id).delete();
}

static Future<void> updateTask(String id , TaskModel task){
    return getTaskCollection().doc(id).update(task.toJson());
}
}