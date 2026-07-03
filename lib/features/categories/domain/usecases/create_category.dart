import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/categories/domain/entities/category.dart';
import 'package:todo_app/features/categories/domain/repositories/category_repository.dart';

class CreateCategoryParams {
  const CreateCategoryParams({
    required this.name,
    required this.colorValue,
    this.iconCodePoint,
  });

  final String name;
  final int colorValue;
  final int? iconCodePoint;
}

class CreateCategoryUseCase implements UseCase<Category, CreateCategoryParams> {
  CreateCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Category> call(CreateCategoryParams params) {
    return _repository.createCategory(
      name: params.name,
      colorValue: params.colorValue,
      iconCodePoint: params.iconCodePoint,
    );
  }
}
