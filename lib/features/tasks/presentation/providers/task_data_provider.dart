import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_datasource_impl.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository_impl.dart';
//import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/usecases/add_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/delete_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/get_tasks.dart';
import 'package:todo_app/features/tasks/domain/usecases/update_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/watch_tasks.dart';

final taskLocalDataSourceProvider =
    Provider<TaskLocalDataSource>(
  (ref) => TaskLocalDataSourceImpl(),
);

final taskRepositoryProvider =
    Provider<TaskRepository>(
  (ref) => TaskRepositoryImpl(
    ref.watch(taskLocalDataSourceProvider),
  ),
);

final createTaskUseCaseProvider =
    Provider<CreateTaskUseCase>(
  (ref) => CreateTaskUseCase(
    ref.watch(taskRepositoryProvider),
  ),
);

final updateTaskUseCaseProvider =
    Provider<UpdateTaskUseCase>(
  (ref) => UpdateTaskUseCase(
    ref.watch(taskRepositoryProvider),
  ),
);

final deleteTaskUseCaseProvider =
    Provider<DeleteTaskUseCase>(
  (ref) => DeleteTaskUseCase(
    ref.watch(taskRepositoryProvider),
  ),
);

final getTasksUseCaseProvider =
    Provider<GetTasksUseCase>(
  (ref) => GetTasksUseCase(
    ref.watch(taskRepositoryProvider),
  ),
);

final watchTasksUseCaseProvider =
    Provider<WatchTasksUseCase>(
  (ref) => WatchTasksUseCase(
    ref.watch(taskRepositoryProvider),
  ),
);
