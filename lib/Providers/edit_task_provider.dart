
import 'package:flutter/material.dart';
import 'package:to_do/DataBase/Collections/task_collection.dart';
import 'package:to_do/DataBase/Model/task.dart';
import 'package:to_do/Providers/auth_provider.dart';



class EditTaskProvider extends ChangeNotifier {
  Task? task;
  AppAuthProvider authProvider = AppAuthProvider();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final formKey = GlobalKey<FormState>();


  initTask(Task task) {
    this.task = task;
    titleController.text = task.title ?? "error title";
    descriptionController.text = task.description ?? "error description";
    selectedDate = DateTime.fromMillisecondsSinceEpoch(task.date ?? 0);
    if (task.time != null) {

      DateTime timeDate = DateTime.fromMillisecondsSinceEpoch(task.time?? 0);
      selectedTime = TimeOfDay(hour: timeDate.hour, minute: timeDate.minute);
    } else {

      selectedTime = TimeOfDay.now();
    }

    notifyListeners();
  }

  String? isValidTask( String value) {
    if (value.isEmpty) {
      return 'field cannot be empty';
    }
    return null;
  }
  updateTask()async {

    if (formKey.currentState!.validate()) {

      notifyListeners();

      task!.title = titleController.text;
      task!.description = descriptionController.text;
      task!.date = selectedDate.millisecondsSinceEpoch;
      task!.time = selectedTime.hour*60*60*1000 + selectedTime.minute*60*1000;
      try{
     await  TasksCollection.updateTask(authProvider.authUser!.uid, task!);
      }
      catch(e){
        print(e);
        
      }

    }
  }


}
