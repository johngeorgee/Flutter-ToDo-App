import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/categories/domain/entities/category.dart';
import 'package:todo_app/features/categories/domain/repositories/category_repository.dart';

class UpdateCategoryParams {
  const UpdateCategoryParams({
    required this.id,
    required this.name,
    required this.colorValue,
    this.iconCodePoint,
  });

  final String id;
  final String name;
  final int colorValue;
  final int? iconCodePoint;
}

class UpdateCategoryUseCase implements UseCase<Category, UpdateCategoryParams> {
  UpdateCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Category> call(UpdateCategoryParams params) {
    return _repository.updateCategory(
      id: params.id,
      name: params.name,
      colorValue: params.colorValue,
      iconCodePoint: params.iconCodePoint,
    );
  }
}
