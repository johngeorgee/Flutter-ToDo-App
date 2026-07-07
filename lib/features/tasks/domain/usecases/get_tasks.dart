import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
//import 'package:todo_app/features/tasks/domain/repositories/task_repository_impl.dart';

class GetTasksUseCase implements UseCase<List<Task>, NoParams> {
  GetTasksUseCase(this._repository);

  final TaskRepository _repository;

  @override
  Future<List<Task>> call(NoParams params) {
    return _repository.getTasks();
  }
}