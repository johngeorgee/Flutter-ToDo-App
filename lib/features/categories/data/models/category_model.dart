import 'package:hive/hive.dart';
import 'package:todo_app/features/categories/domain/entities/category.dart';
part 'category_model.g.dart';
@HiveType(typeId: 0)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int colorValue;

  @HiveField(3)
  int? iconCodePoint;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;
  CategoryModel({
    required this.id,
    required this.name,
    required this.colorValue,
    this.iconCodePoint,
    required this.createdAt,
    required this.updatedAt,
  });

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      colorValue: colorValue,
      iconCodePoint: iconCodePoint,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      colorValue: category.colorValue,
      iconCodePoint: category.iconCodePoint,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    int? colorValue,
    int? iconCodePoint,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

 