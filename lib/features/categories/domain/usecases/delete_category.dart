import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/categories/domain/repositories/category_repository.dart';

class DeleteCategoryParams {
  const DeleteCategoryParams(this.id);

  final String id;
}

class DeleteCategoryUseCase implements UseCase<void, DeleteCategoryParams> {
  DeleteCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  @override
  Future<void> call(DeleteCategoryParams params) {
    return _repository.deleteCategory(params.id);
  }
}
