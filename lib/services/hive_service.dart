import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/constants/hive_constants.dart';
import 'package:todo_app/features/categories/data/models/category_model.dart';
//import 'package:todo_app/features/categories/data/models/category_model.g.dart';
import 'package:todo_app/features/tasks/data/models/task_model.dart';

abstract final class HiveService {
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(HiveConstants.categoryTypeId)) {
      Hive.registerAdapter(CategoryModelAdapter());
    }

     if (!Hive.isAdapterRegistered(HiveConstants.taskTypeId)) {
       Hive.registerAdapter(TaskModelAdapter());
  }

    await Future.wait([
      Hive.openBox<TaskModel>(HiveConstants.tasksBox),
      Hive.openBox<CategoryModel>(HiveConstants.categoriesBox),
    ]);

    _initialized = true;
  }

  static Box<TaskModel> get tasksBox => 
    Hive.box<TaskModel>(HiveConstants.tasksBox);

  static Box<CategoryModel> get categoriesBox =>
      Hive.box<CategoryModel>(HiveConstants.categoriesBox);
}
