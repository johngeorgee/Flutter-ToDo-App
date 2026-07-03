import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/categories/domain/entities/category.dart';
import 'package:todo_app/features/categories/domain/repositories/category_repository.dart';

class GetCategoriesUseCase implements UseCase<List<Category>, NoParams> {
  GetCategoriesUseCase(this._repository);

  final CategoryRepository _repository;

  @override
  Future<List<Category>> call(NoParams params) async {
    return _repository.getCategories();
  }
}
