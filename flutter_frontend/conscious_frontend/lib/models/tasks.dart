class Task{
  int? id;
  String? title;
  String? description;
  DateTime? dueDate;
  bool? isCompleted;

  Task({
    this.id,
    this.title,
    this.description,
    this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    dueDate = DateTime.parse(json['dueDate']);
    isCompleted = json['isCompleted'];
  }
}

