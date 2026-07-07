import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:hive/hive.dart';
import 'package:todo_app/app.dart';
//import 'package:todo_app/core/constants/hive_constants.dart';
//import 'package:todo_app/features/tasks/data/models/task_model.dart';
import 'package:todo_app/services/hive_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();


  runApp(
     const ProviderScope(
      child: TodoApp(),
    ),
  );
}
