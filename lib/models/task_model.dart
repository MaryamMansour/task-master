import 'dart:developer';

class TaskModel{
  String id;
  String title;
  String description;
  int date;
  bool status;



  TaskModel({this.id='',
    required this.title,
    required this.date,
    required this.description,
    required this.status});

  //     As a named Constructor
  TaskModel.fromJson(Map<String, dynamic>json): this(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      description: json['description'],
      status: json['status']
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
      "status":status
    };
    return json;
  }


}