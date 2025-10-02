// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:conscious_frontend/models/tasks.dart';
// import 'package:conscious_frontend/tasks/task_helper.dart';
// import 'package:conscious_frontend/tasks/task_bloc/task_bloc.dart';
//
// class TaskChecklistPage extends StatefulWidget {
//   static const String routeName = '/task_checklist';
//   static const String routeAlias = 'task_checklist';
//   @override
//   _TaskChecklistPageState createState() => _TaskChecklistPageState();
// }
//
// class _TaskChecklistPageState extends State<TaskChecklistPage> {
//
//   final TaskListBloc _taskBloc = TaskListBloc();
//
//   toggleTaskCompletion(Task task) {
//     setState(() {
//       task.isCompleted = !(task.isCompleted ?? false);
//     });
//   }
//
//   void openTaskDetail(Task task) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => TaskDetailPage(task: task),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Task Checklist')),
//       body: BlocBuilder(
//         bloc: _taskBloc,
//         builder: (context, state) {
//           List<Task> tasks = [];
//           if (state is TaskListLoadInProgress) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is TaskListLoadFailure) {
//             return Center(child: Text('Failed to load tasks'));
//           } else if (state is TaskListLoadSuccess) {
//             tasks = state.tasks ?? [];
//           }
//           return ListView.builder(
//             itemBuilder: (context, index) {
//               final task = tasks[index];
//               return GestureDetector(
//                 onTap: () => openTaskDetail(task),
//                 child: CheckboxListTile(
//
//                   value: task.isCompleted ?? false,
//                   onChanged: (_) => toggleTaskCompletion(task),
//                   title: Text(
//                     task.title ?? '',
//                     style: TextStyle(
//                       decoration:
//                           (task.isCompleted ?? false)
//                               ? TextDecoration.lineThrough
//                               : TextDecoration.none,
//                     ),
//                   ),
//                   subtitle: Text(
//                     task.dueDate != null
//                         ? 'Due: ${task.dueDate!.toLocal().toString().split(' ')[0]}'
//                         : '',
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           TaskHelper()
//               .add_task("Task Title", 'Task description', DateTime.now())
//               .then((success) {
//                 if (success) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Task added successfully!')),
//                   );
//                   Navigator.pop(context); // Go back to the checklist
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Failed to add task.')),
//                   );
//                 }
//               });
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class TaskDetailPage extends StatelessWidget {
//   final Task task;
//
//   TaskDetailPage({required this.task});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(task.title ?? 'Task Detail')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text(
//           task.description ?? 'No description provided.',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
