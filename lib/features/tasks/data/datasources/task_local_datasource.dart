import 'package:hive_flutter/hive_flutter.dart';
//import 'package:todo_app/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_datasource_impl.dart';
import 'package:todo_app/features/tasks/data/models/task_model.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
//import 'package:todo_app/services/hive_service.dart';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  static const String boxName = 'tasks';

  Box<TaskModel> get _box => Hive.box<TaskModel>(boxName);

  @override
  Future<Task> createTask(Task task) async {
    final model = TaskModel.fromEntity(task);

    await _box.put(task.id, model);

    return model.toEntity();
  }

  @override
  Future<void> deleteTask(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<Task>> getTasks() async {
    return _box.values.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Task> updateTask(Task task) async {
    final model = TaskModel.fromEntity(task);

    await _box.put(task.id, model);

    return model.toEntity();
  }

  @override
  Stream<List<Task>> watchTasks() async* {

    yield _box.values.map((e) => e.toEntity()).toList();

    yield* _box.watch().map((_) {
      return _box.values.map((e) => e.toEntity()).toList();
    });
  }
}