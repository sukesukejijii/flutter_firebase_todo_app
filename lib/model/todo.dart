import '../utils.dart';

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.id = '',
    this.description = '',
    this.isDone = false,
  });

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      createdTime: Utils.toDateTime(json['createdTime']),
      title: json['title'],
      description: json['description'],
      id: json['id'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdTime': Utils.fromDateTimeToJson(createdTime),
      'title': title,
      'description': description,
      'id': id,
      'isDone': isDone,
    };
  }
}
