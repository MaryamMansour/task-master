import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/user_model.dart';

import '../../models/task_model.dart';

class FireBaseFunctions{


  // IT point on the collection
  static CollectionReference<TaskModel> getTaskCollection()
  {
    return FirebaseFirestore.instance.collection(TaskModel.COLLECTION_NAME)
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
    .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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


static Future<UserModel?> readUser(String id)async{

  DocumentSnapshot<UserModel> userSnap=
  await getUserCollection().doc(id).get();
  return userSnap.data();
}



// static void createAcoount (String name, int age,String email, String password, Function created)async{
//   try {
//     final credential = await FirebaseAuth.instance.
//     createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     //credential.user!.sendEmailVerification(); email verify
//     //FirebaseAuth.instance.sendPasswordResetEmail(email: "email")
//     UserModel userModel = UserModel(id: credential.user!.uid
//         ,name: name, email: email, age: age);
//   addUserToFirestore(userModel).then((value) { created();});
//
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print(e.message);
//     } else if (e.code == 'email-already-in-use') {
//       print(e.message);
//     }
//   } catch (e) {
//     print(e);
//   }
// }






  static CollectionReference<UserModel> getUserCollection()
  {
    return FirebaseFirestore.instance.
    collection(UserModel.COLLECTION_NAME)
        .withConverter<UserModel>(
      fromFirestore: (snapshot,options) {
         return UserModel.fromJson(snapshot.data()!);
          },
      toFirestore: (user,options) {
        return user.toJson();
      }
    );
  }

  static Future <void> addUserToFirestore(UserModel user){
    var collection = getUserCollection();
    var docRef= collection.doc(user.id);
      return docRef.set(user);
  }

  // static void Login(String email, String password , Function onError,Function logged )async
  // {
  //
  // }


}