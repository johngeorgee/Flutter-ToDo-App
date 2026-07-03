import 'package:todo_app/features/categories/domain/entities/category.dart';

abstract interface class CategoryRepository {
  List<Category> getCategories();

  Category? getCategoryById(String id);

  Future<Category> createCategory({
    required String name,
    required int colorValue,
    int? iconCodePoint,
  });

  Future<Category> updateCategory({
    required String id,
    required String name,
    required int colorValue,
    int? iconCodePoint,
  });

  Future<void> deleteCategory(String id);

  Stream<List<Category>> watchCategories();
}
