import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_backend/models/task.dart';
import 'package:flutter_b6_backend/services/task.dart';
import 'package:flutter_b6_backend/views/add_task.dart';
import 'package:flutter_b6_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get All Tasks"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTaskView()));
          },
          child: Icon(Icons.add),
        ),
        body: StreamProvider.value(
          value: TaskServices().getAllTasks(),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
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
                                          UpdateTaskView(model: taskList[i])));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () async {
                              await TaskServices()
                                  .deleteTask(taskList[i].docId.toString());
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  );
                });
          },
        ));
  }
}
