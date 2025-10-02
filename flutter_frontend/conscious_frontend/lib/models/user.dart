import 'tasks.dart';
class User{
  String? name;
  String? email;
  List<Task>? tasks;

  User({
    this.name,
    this.email,
    this.tasks,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'tasks': tasks?.map((task) => task.toJson()).toList(),
    };
  }
  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    if (json['tasks'] != null) {
      print(json['tasks']);
      tasks = <Task>[];
      json['tasks'].forEach((v) {
        tasks!.add(Task.fromJson(v));
      });
    }
  }
}