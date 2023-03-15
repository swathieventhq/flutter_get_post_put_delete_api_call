class Todo {
  Todo({
    this.userId,
    this.id,
    this.title,
    this.completed,});

  Todo.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  int? userId;
  int? id;
  String? title;
  bool? completed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId.toString();
    map['id'] = id.toString();
    map['title'] = title;
    map['completed'] = completed.toString();
    return map;
  }
}
