// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  int? id;
  late String title;
  String? description;
  late String date;

  Todo(
      {this.id,
      required this.title,
      required this.description,
      required this.date});

//Convert a Note object to a Map opject
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    return map;
  }

  //Extract a Note object to a Map object
  Todo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    date = map['date'];
  }

  @override
  String toString() {
    return 'UserData(id : $id, title : $title, description : $description, date : $date)';
  }

  @override
  List<Object?> get props => [title, description, date];
}
