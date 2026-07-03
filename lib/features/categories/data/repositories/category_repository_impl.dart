import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/categories/data/datasources/category_local_datasource.dart';
import 'package:todo_app/features/categories/data/models/category_model.dart';
import 'package:todo_app/features/categories/domain/entities/category.dart';
import 'package:todo_app/features/categories/domain/repositories/category_repository.dart';
import 'package:uuid/uuid.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._localDataSource);

  final CategoryLocalDataSource _localDataSource;
  final _uuid = const Uuid();

  @override
  List<Category> getCategories() {
    return _localDataSource.getAll().map((m) => m.toEntity()).toList();
  }

  @override
  Category? getCategoryById(String id) {
    return _localDataSource.getById(id)?.toEntity();
  }

  @override
  Future<Category> createCategory({
    required String name,
    required int colorValue,
    int? iconCodePoint,
  }) async {
    final trimmedName = name.trim();
    _validateName(trimmedName);

    if (_localDataSource.existsByName(trimmedName)) {
      throw DuplicateFailure('A category named "$trimmedName" already exists');
    }

    final now = DateTime.now();
    final model = CategoryModel(
      id: _uuid.v4(),
      name: trimmedName,
      colorValue: colorValue,
      iconCodePoint: iconCodePoint,
      createdAt: now,
      updatedAt: now,
    );

    await _localDataSource.save(model);
    return model.toEntity();
  }

  @override
  Future<Category> updateCategory({
    required String id,
    required String name,
    required int colorValue,
    int? iconCodePoint,
  }) async {
    final trimmedName = name.trim();
    _validateName(trimmedName);

    final existing = _localDataSource.getById(id);
    if (existing == null) {
      throw const NotFoundFailure('Category not found');
    }

    if (_localDataSource.existsByName(trimmedName, excludeId: id)) {
      throw DuplicateFailure('A category named "$trimmedName" already exists');
    }

    final updated = existing.copyWith(
      name: trimmedName,
      colorValue: colorValue,
      iconCodePoint: () => iconCodePoint,
      updatedAt: DateTime.now(),
    );

    await _localDataSource.save(updated);
    return updated.toEntity();
  }

  @override
  Future<void> deleteCategory(String id) async {
    final existing = _localDataSource.getById(id);
    if (existing == null) {
      throw const NotFoundFailure('Category not found');
    }

    await _localDataSource.delete(id);
  }

  @override
  Stream<List<Category>> watchCategories() {
    return _localDataSource.watchAll().map(
          (models) => models.map((m) => m.toEntity()).toList(),
        );
  }

  void _validateName(String name) {
    if (name.isEmpty) {
      throw const ValidationFailure('Category name is required');
    }
  }
}
