import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b6_backend/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('taskCollection').doc();
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
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
  Stream<List<TaskModel>> getAllTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .snapshots()
        .map((taskList) {
      return taskList.docs
          .map((taskModel) => TaskModel.fromJson(taskModel.data()))
          .toList();
    });
  }

  ///Get Completed Tasks
  Stream<List<TaskModel>> getCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((taskList) {
      return taskList.docs
          .map((taskModel) => TaskModel.fromJson(taskModel.data()))
          .toList();
    });
  }

  ///Get InCompleted Tasks
  Stream<List<TaskModel>> getInCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((taskList) {
      return taskList.docs
          .map((taskModel) => TaskModel.fromJson(taskModel.data()))
          .toList();
    });
  }

  ///Mark task as complete
  Future markTaskAsComplete(String taskID) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({'isCompleted': true});
  }
}
