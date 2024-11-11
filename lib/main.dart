import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_backend/views/add_task.dart';
import 'package:flutter_b6_backend/views/get_all_task.dart';
import 'package:flutter_b6_backend/views/get_completed_task.dart';
import 'package:flutter_b6_backend/views/get_in_completed_task.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:GetAllTaskView(),
    );
  }
}
