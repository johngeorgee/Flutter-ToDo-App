import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';
//import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';
//import 'package:todo_app/features/tasks/domain/repositories/task_repository_impl.dart';

class DeleteTaskUseCase implements UseCase<void, DeleteTaskParams> {
  DeleteTaskUseCase(this._repository);

  final TaskRepository _repository;

  @override
  Future<void> call(DeleteTaskParams params) {
    return _repository.deleteTask(params.id);
  }
}

class DeleteTaskParams {
  const DeleteTaskParams(this.id);

  final String id;
}