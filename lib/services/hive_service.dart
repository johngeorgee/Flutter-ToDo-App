import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/constants/hive_constants.dart';
import 'package:todo_app/features/categories/data/models/category_model.dart';
import 'package:todo_app/features/categories/data/models/category_model.g.dart';

abstract final class HiveService {
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(HiveConstants.categoryTypeId)) {
      Hive.registerAdapter(CategoryModelAdapter());
    }

    await Future.wait([
      Hive.openBox<CategoryModel>(HiveConstants.categoriesBox),
    ]);

    _initialized = true;
  }

  static Box<CategoryModel> get categoriesBox =>
      Hive.box<CategoryModel>(HiveConstants.categoriesBox);
}
