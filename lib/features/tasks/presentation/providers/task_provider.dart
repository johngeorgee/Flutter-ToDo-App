import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_app/features/tasks/presentation/providers/task_data_provider.dart';
import 'package:todo_app/features/tasks/presentation/providers/task_notifier.dart';

final tasksStreamProvider =
    StreamProvider<List<Task>>(
  (ref) {
    return ref
        .watch(watchTasksUseCaseProvider)
        .call(const NoParams());
  },
);
final completedTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksStreamProvider).valueOrNull ?? [];

  return tasks.where((task) => task.isCompleted).toList();
});
final taskByIdProvider =
    Provider.family<Task?, String>(
  (ref, id) {
    final tasks = ref.watch(tasksStreamProvider).valueOrNull;

    if (tasks == null) return null;

    try {
      return tasks.firstWhere(
        (task) => task.id == id,
      );
    } catch (_) {
      return null;
    }
  },
);

final taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, AsyncValue<void>>(
  (ref) => TaskNotifier(ref),
);