import 'dart:developer';

class TaskModel{
  static const String COLLECTION_NAME="Tasks";

  String id;
  String title;
  String description;
  int date;
  bool status;
  String userId;



  TaskModel({this.id='',
    required this.title,
    required this.date,
    required this.description,
    required this.status,
    required this.userId});

  //     As a named Constructor
  TaskModel.fromJson(Map<String, dynamic>json): this(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      description: json['description'],
      status: json['status'],
    userId: json['userId']
  );

  //      As a Function


  // TaskModel fromJson(Map <String,dynamic>json)
  // {
  //   TaskModel taskModel=
  //   TaskModel(
  //       id: json['id'],
  //       title: json['title'],
  //       date: json['date'],
  //       description: json['description'],
  //       status: json['status']);
  //   return taskModel;
  // }

  Map<String, dynamic> toJson()
  {
    Map<String, dynamic> json;
    json={
      "id":id,
      "title":title,
      "date":date,
      "description":description,
      "status":status,
      "userId":userId
    };
    return json;
  }


}