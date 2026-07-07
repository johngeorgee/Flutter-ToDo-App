import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_app/features/tasks/domain/entities/task_priority.dart';
import 'package:todo_app/features/tasks/domain/usecases/add_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/delete_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/update_task.dart';
import 'task_data_provider.dart';

class TaskNotifier extends StateNotifier<AsyncValue<void>> {
  TaskNotifier(this.ref)
      : super(const AsyncData(null));

  final Ref ref;

  Future<Task> create({
    required String title,
    required String description,
    required String? categoryId,
    required TaskPriority priority,
    DateTime? dueDate,
  }) async {
    state = const AsyncLoading();

    late Task task;

    state = await AsyncValue.guard(() async {
      task = await ref.read(createTaskUseCaseProvider).call(
            CreateTaskParams(
              title: title,
              description: description,
              categoryId: categoryId,
              priority: priority,
              dueDate: dueDate,
            ),
          );
    });

    if (state.hasError) throw state.error!;

    return task;
  }

  Future<Task> update({
    required String id,
    required String title,
    required String description,
    required String? categoryId,
    required TaskPriority priority,
    DateTime? dueDate,
    required bool isCompleted,
    required DateTime createdAt,
  }) async {
    state = const AsyncLoading();

    late Task task;

    state = await AsyncValue.guard(() async {
      task = await ref.read(updateTaskUseCaseProvider).call(
            UpdateTaskParams(
              id: id,
              title: title,
              description: description,
              categoryId: categoryId,
              priority: priority,
              dueDate: dueDate,
              isCompleted: isCompleted,
              createdAt: createdAt,
            ),
          );
    });

    if (state.hasError) throw state.error!;

    return task;
  }

  Future<void> delete(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(deleteTaskUseCaseProvider).call(
            DeleteTaskParams(id),
          );
    });

    if (state.hasError) throw state.error!;
  }

  Future<void> toggleCompleted(Task task) async {
    await update(
      id: task.id,
      title: task.title,
      description: task.description,
      categoryId: task.categoryId,
      priority: task.priority,
      dueDate: task.dueDate,
      isCompleted: !task.isCompleted,
      createdAt: task.createdAt,
    );
  }
}