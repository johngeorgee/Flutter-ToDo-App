import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/categories/data/datasources/category_local_datasource.dart';
import 'package:todo_app/features/categories/data/models/category_model.dart';
import 'package:todo_app/services/hive_service.dart';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  CategoryLocalDataSourceImpl();

  @override
  List<CategoryModel> getAll() {
    try {
      final box = HiveService.categoriesBox;
      return box.values.toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } catch (_) {
      throw const CacheFailure('Failed to read categories');
    }
  }

  @override
  CategoryModel? getById(String id) {
    try {
      return HiveService.categoriesBox.get(id);
    } catch (_) {
      throw const CacheFailure('Failed to read category');
    }
  }

  @override
  Future<void> save(CategoryModel category) async {
    try {
      await HiveService.categoriesBox.put(category.id, category);
    } catch (_) {
      throw const CacheFailure('Failed to save category');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await HiveService.categoriesBox.delete(id);
    } catch (_) {
      throw const CacheFailure('Failed to delete category');
    }
  }

  @override
  bool existsByName(String name, {String? excludeId}) {
    final normalized = name.trim().toLowerCase();
    return HiveService.categoriesBox.values.any(
      (category) =>
          category.name.trim().toLowerCase() == normalized &&
          category.id != excludeId,
    );
  }

  @override
  Stream<List<CategoryModel>> watchAll() async* {
    final box = HiveService.categoriesBox;
    yield getAll();
    await for (final _ in box.watch()) {
      yield getAll();
    }
  }
}
