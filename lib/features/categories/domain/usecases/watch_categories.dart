import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/categories/domain/entities/category.dart';
import 'package:todo_app/features/categories/domain/repositories/category_repository.dart';

class WatchCategoriesUseCase implements StreamUseCase<List<Category>, NoParams> {
  WatchCategoriesUseCase(this._repository);

  final CategoryRepository _repository;

  @override
  Stream<List<Category>> call(NoParams params) {
    return _repository.watchCategories();
  }
}
