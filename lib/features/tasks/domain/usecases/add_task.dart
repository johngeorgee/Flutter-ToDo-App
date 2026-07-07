import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_app/features/tasks/domain/entities/task_priority.dart';
//import 'package:todo_app/features/tasks/domain/repositories/task_repository_impl.dart';

class CreateTaskUseCase
    implements UseCase<Task, CreateTaskParams> {
  CreateTaskUseCase(this._repository);

  final TaskRepository _repository;

  @override
  Future<Task> call(CreateTaskParams params) {
    final now = DateTime.now();

    final task = Task(
      id: const Uuid().v4(),
      title: params.title,
      description: params.description,
      categoryId: params.categoryId,
      priority: params.priority,
      dueDate: params.dueDate,
      isCompleted: false,
      createdAt: now,
      updatedAt: now,
    );

    return _repository.createTask(task);
  }
}

class CreateTaskParams {
  const CreateTaskParams({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.priority,
    this.dueDate,
  });

  final String title;
  final String description;
  final String? categoryId;
  final TaskPriority priority;
  final DateTime? dueDate;
}