import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_app/features/tasks/domain/entities/task_priority.dart';
//import 'package:todo_app/features/tasks/domain/repositories/task_repository_impl.dart';

class UpdateTaskUseCase
    implements UseCase<Task, UpdateTaskParams> {
  UpdateTaskUseCase(this._repository);

  final TaskRepository _repository;

  @override
  Future<Task> call(UpdateTaskParams params) {
    final task = Task(
      id: params.id,
      title: params.title,
      description: params.description,
      categoryId: params.categoryId,
      priority: params.priority,
      dueDate: params.dueDate,
      isCompleted: params.isCompleted,
      createdAt: params.createdAt,
      updatedAt: DateTime.now(),
    );

    return _repository.updateTask(task);
  }
}

class UpdateTaskParams {
  const UpdateTaskParams({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.priority,
    required this.isCompleted,
    required this.createdAt,
    this.dueDate,
  });

  final String id;
  final String title;
  final String description;
  final String? categoryId;
  final TaskPriority priority;
  final DateTime? dueDate;
  final bool isCompleted;
  final DateTime createdAt;
}