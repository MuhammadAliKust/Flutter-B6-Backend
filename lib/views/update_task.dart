import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_backend/models/task.dart';
import 'package:flutter_b6_backend/services/task.dart';
import 'package:loading_overlay/loading_overlay.dart';

class UpdateTaskView extends StatefulWidget {
  final TaskModel model;

  UpdateTaskView({super.key, required this.model});

  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    titleController =
        TextEditingController(text: widget.model.title.toString());
    descriptionController =
        TextEditingController(text: widget.model.description.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Task"),
        ),
        body: Column(
          children: [
            TextField(
              controller: titleController,
            ),
            TextField(
              controller: descriptionController,
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Title cannot be empty.")));
                    return;
                  }
                  if (descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Description cannot be empty.")));
                    return;
                  }
                  try {
                    isLoading = true;
                    setState(() {});
                    await TaskServices()
                        .updateTask(TaskModel(
                            title: titleController.text,
                            description: descriptionController.text,
                            docId: widget.model.docId.toString()))
                        .then((val) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Message"),
                              content:
                                  Text("Task has been updated successfully"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      titleController.clear();
                                      descriptionController.clear();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Okay"))
                              ],
                            );
                          });
                    });
                    isLoading = false;
                    setState(() {});
                  } catch (e) {
                    isLoading = false;

                    setState(() {});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text("Update Task"))
          ],
        ),
      ),
    );
  }
}
