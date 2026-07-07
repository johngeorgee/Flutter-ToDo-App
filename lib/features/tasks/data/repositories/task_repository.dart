import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';

abstract interface class TaskRepository {
  Future<List<Task>> getTasks();

  Stream<List<Task>> watchTasks();

  Future<Task> createTask(Task task);

  Future<Task> updateTask(Task task);

  Future<void> deleteTask(String id);
}