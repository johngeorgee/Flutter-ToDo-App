import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/categories/data/datasources/category_local_datasource.dart';
import 'package:todo_app/features/categories/data/datasources/category_local_datasource_impl.dart';
import 'package:todo_app/features/categories/data/repositories/category_repository_impl.dart';
import 'package:todo_app/features/categories/domain/entities/category.dart';
import 'package:todo_app/features/categories/domain/repositories/category_repository.dart';
import 'package:todo_app/features/categories/domain/usecases/create_category.dart';
import 'package:todo_app/features/categories/domain/usecases/delete_category.dart';
import 'package:todo_app/features/categories/domain/usecases/get_categories.dart';
import 'package:todo_app/features/categories/domain/usecases/update_category.dart';
import 'package:todo_app/features/categories/domain/usecases/watch_categories.dart';

// --- Data layer providers ---

final categoryLocalDataSourceProvider = Provider<CategoryLocalDataSource>(
  (ref) => CategoryLocalDataSourceImpl(),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(ref.watch(categoryLocalDataSourceProvider)),
);

// --- Use case providers ---

final getCategoriesUseCaseProvider = Provider(
  (ref) => GetCategoriesUseCase(ref.watch(categoryRepositoryProvider)),
);

final watchCategoriesUseCaseProvider = Provider(
  (ref) => WatchCategoriesUseCase(ref.watch(categoryRepositoryProvider)),
);

final createCategoryUseCaseProvider = Provider(
  (ref) => CreateCategoryUseCase(ref.watch(categoryRepositoryProvider)),
);

final updateCategoryUseCaseProvider = Provider(
  (ref) => UpdateCategoryUseCase(ref.watch(categoryRepositoryProvider)),
);

final deleteCategoryUseCaseProvider = Provider(
  (ref) => DeleteCategoryUseCase(ref.watch(categoryRepositoryProvider)),
);

// --- Presentation providers ---

final categoriesStreamProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(watchCategoriesUseCaseProvider).call(const NoParams());
});

final categoryByIdProvider = Provider.family<Category?, String>((ref, id) {
  final categories = ref.watch(categoriesStreamProvider).valueOrNull;
  if (categories == null) return null;
  try {
    return categories.firstWhere((c) => c.id == id);
  } catch (_) {
    return null;
  }
});

class CategoryNotifier extends StateNotifier<AsyncValue<void>> {
  CategoryNotifier(this._ref) : super(const AsyncData(null));

  final Ref _ref;

  Future<Category> create({
    required String name,
    required int colorValue,
    int? iconCodePoint,
  }) async {
    state = const AsyncLoading();
    late Category result;
    state = await AsyncValue.guard(() async {
      result = await _ref.read(createCategoryUseCaseProvider).call(
            CreateCategoryParams(
              name: name,
              colorValue: colorValue,
              iconCodePoint: iconCodePoint,
            ),
          );
    });
    if (state.hasError) throw state.error!;
    return result;
  }

  Future<Category> update({
    required String id,
    required String name,
    required int colorValue,
    int? iconCodePoint,
  }) async {
    state = const AsyncLoading();
    late Category result;
    state = await AsyncValue.guard(() async {
      result = await _ref.read(updateCategoryUseCaseProvider).call(
            UpdateCategoryParams(
              id: id,
              name: name,
              colorValue: colorValue,
              iconCodePoint: iconCodePoint,
            ),
          );
    });
    if (state.hasError) throw state.error!;
    return result;
  }

  Future<void> delete(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _ref.read(deleteCategoryUseCaseProvider).call(
            DeleteCategoryParams(id),
          );
    });
    if (state.hasError) throw state.error!;
  }
}

final categoryNotifierProvider =
    StateNotifierProvider<CategoryNotifier, AsyncValue<void>>(
  (ref) => CategoryNotifier(ref),
);
