import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:to_do/DataBase/Collections/task_collection.dart';
import 'package:to_do/DataBase/Model/task.dart';
import 'package:to_do/UI/Utility/date_utils.dart';

class TasksProvider extends ChangeNotifier {
  var tasksCollection = TasksCollection();
  String? toggledTaskId;
  List<Task> _tasks = [];


  Future<List<Task>> getAllTasks(String userId, DateTime selectedDate) async {
    var tasksList = await tasksCollection.getTasks(
        userId, selectedDate.dateOnly());
    return tasksList;
  }

  Future<void> removeTasks(String userId, Task task) async {
    await tasksCollection.removeTask(userId, task);
    notifyListeners();
    return;
  }

  Future<void> createTask(String userId, Task task) async {
    await tasksCollection.createTask(userId, task);
    notifyListeners();
    return;
  }


  Future<void> isTaskToggled(String userId, Task task) async {
    task.isToggled = !(task.isToggled ?? false);


    var docRef = TasksCollection.getTasksCollection(userId).doc(task.id);
    await docRef.update({'isToggled': task.isToggled});

    notifyListeners();
  }




  static TasksProvider getInstance(BuildContext context, {bool listen = true}) {
    return Provider.of<TasksProvider>(context, listen: listen);
  }
  List<Task> get tasks => _tasks;
}
