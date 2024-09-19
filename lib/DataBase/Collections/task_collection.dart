import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/DataBase/Model/task.dart';

class TasksCollection {
  Future<void> createTask(String userId, Task task ) async {
   var docRef = getTasksCollection(userId).doc();
   task.id = docRef.id;
  return  docRef.set(task);

  }

  static CollectionReference<Task> getTasksCollection(userId) {
    var db = FirebaseFirestore.instance;

    return db.collection("users").doc(userId).collection("tasks").withConverter(
        fromFirestore: (snapshot, options) {
          return Task.fromFireStore(snapshot.data());
        },
        toFirestore: (task, options) {
          return
            task.toFireStore();

        }
    );
  }

  Future<List<Task>> getTasks(String userId, int selectedDate) async {
    var querySnapshot =  await getTasksCollection(userId).where("date",isEqualTo: selectedDate).orderBy('time',descending: false).get();

    var tasksList= querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
    return tasksList;
  }

  Stream<QuerySnapshot<Task>> listenForTasks(String userId, int selectedDate) async* {
    yield*  getTasksCollection(userId).where("date",isEqualTo: selectedDate).orderBy('time',descending: false).snapshots();

  }

  Future<void> removeTask(String userId, Task task) {
   var docRef = getTasksCollection(userId).doc(task.id?? " #todo");

   return docRef.delete();
  }


static updateTask(String userId, Task task) async {
    try{

      var docRef = getTasksCollection(userId).doc(task.id);
      await docRef.update(task.toFireStore());

    } catch(e){
      throw e .toString();

    }
}




}
