import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_backend/models/task.dart';
import 'package:flutter_b6_backend/services/task.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: StreamProvider.value(
          value: TaskServices()
              .getAllTasks(FirebaseAuth.instance.currentUser!.uid),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> allTaskList = context.watch<List<TaskModel>>();
            return StreamProvider.value(
                value: TaskServices()
                    .getCompletedTasks(FirebaseAuth.instance.currentUser!.uid),
                initialData: [TaskModel()],
                builder: (context, child) {
                  List<TaskModel> completedTaskList =
                      context.watch<List<TaskModel>>();
                  return StreamProvider.value(
                      value: TaskServices().getInCompletedTasks(
                          FirebaseAuth.instance.currentUser!.uid),
                      initialData: [TaskModel()],
                      builder: (context, child) {
                        List<TaskModel> inCompletedTaskList =
                            context.watch<List<TaskModel>>();
                        return Column(
                          children: [
                            Text(
                              "Total Tasks: ${allTaskList.length}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Completed Tasks: ${completedTaskList.length}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "InCompleted Tasks: ${inCompletedTaskList.length}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        );
                      });
                });
          }),
    );
  }
}
