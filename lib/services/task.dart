import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b6_backend/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .add(model.toJson());
  }

  ///Update Task
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({
      "title": model.title,
      "description": model.description,
    });
  }

  ///Delete Task
  Future deleteTask(String taskID) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .delete();
  }

  ///Get All Tasks
  ///Get Completed Tasks
  ///Get InCompleted Tasks
  ///Mark task as complete
  Future markTaskAsComplete(String taskID) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({'isCompleted': true});
  }
}
