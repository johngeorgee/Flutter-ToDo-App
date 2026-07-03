import 'package:todo_app/features/categories/data/models/category_model.dart';

abstract interface class CategoryLocalDataSource {
  List<CategoryModel> getAll();

  CategoryModel? getById(String id);

  Future<void> save(CategoryModel category);

  Future<void> delete(String id);

  bool existsByName(String name, {String? excludeId});

  Stream<List<CategoryModel>> watchAll();
}
