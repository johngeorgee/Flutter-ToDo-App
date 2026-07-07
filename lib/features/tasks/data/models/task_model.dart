import 'package:hive/hive.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_app/features/tasks/domain/entities/task_priority.dart';
part 'task_model.g.dart';
@HiveType(typeId: 1)
class TaskModel extends HiveObject {
   @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String? categoryId;

  @HiveField(4)
  int priority;

  @HiveField(5)
  DateTime? dueDate;

  @HiveField(6)
  bool isCompleted;

  @HiveField(7)
  DateTime createdAt;

  @HiveField(8)
  DateTime updatedAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.categoryId,  // ✅ خليها optional
    required this.priority,
    this.dueDate,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      categoryId: categoryId,
      priority: TaskPriority.values[priority],
      dueDate: dueDate,
      isCompleted: isCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      categoryId: task.categoryId,
      priority: task.priority.index,
      dueDate: task.dueDate,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? categoryId,
    int? priority,
    DateTime? dueDate,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

 