import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
//import 'package:todo_app/features/tasks/domain/repositories/task_repository_impl.dart';

class WatchTasksUseCase
    implements StreamUseCase<List<Task>, NoParams> {
  WatchTasksUseCase(this._repository);

  final TaskRepository _repository;

  @override
  Stream<List<Task>> call(NoParams params) {
    return _repository.watchTasks();
  }
}