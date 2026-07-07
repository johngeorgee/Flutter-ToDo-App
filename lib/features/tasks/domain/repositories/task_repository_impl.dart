//import 'package:todo_app/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_datasource_impl.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
//import 'package:todo_app/features/tasks/domain/repositories/task_repository_impl.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl(this._localDataSource);

  final TaskLocalDataSource _localDataSource;

  @override
  Future<Task> createTask(Task task) {
    return _localDataSource.createTask(task);
  }

  @override
  Future<void> deleteTask(String id) {
    return _localDataSource.deleteTask(id);
  }

  @override
  Future<List<Task>> getTasks() {
    return _localDataSource.getTasks();
  }

  @override
  Future<Task> updateTask(Task task) {
    return _localDataSource.updateTask(task);
  }

  @override
  Stream<List<Task>> watchTasks() {
    return _localDataSource.watchTasks();
  }
}