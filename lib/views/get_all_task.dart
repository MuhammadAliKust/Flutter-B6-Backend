import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_backend/models/task.dart';
import 'package:flutter_b6_backend/services/task.dart';
import 'package:flutter_b6_backend/views/add_task.dart';
import 'package:flutter_b6_backend/views/profile_view.dart';
import 'package:flutter_b6_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get All Tasks"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileView()));
                },
                icon: Icon(Icons.person))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTaskView()));
          },
          child: Icon(Icons.add),
        ),
        body: StreamProvider.value(
          value: TaskServices()
              .getAllTasks(FirebaseAuth.instance.currentUser!.uid),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return taskList.isNotEmpty
                ? taskList[0].docId == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: taskList.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Icon(Icons.task),
                            title: Text(taskList[i].title.toString()),
                            subtitle: Text(taskList[i].description.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CupertinoSwitch(
                                    value: taskList[i].isCompleted!,
                                    onChanged: (val) async {
                                      await TaskServices().markTaskAsComplete(
                                          taskList[i].docId.toString());
                                    }),
                                IconButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateTaskView(
                                                      model: taskList[i])));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      await TaskServices().deleteTask(
                                          taskList[i].docId.toString());
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          );
                        })
                : Center(
                    child: Text("NO Data Found!"),
                  );
          },
        ));
  }
}
