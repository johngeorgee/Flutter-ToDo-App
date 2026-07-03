import 'package:flutter/material.dart';
import 'package:todo_app/core/widgets/app_scaffold.dart';
import 'package:todo_app/features/tasks/presentation/widgets/category_chip.dart';
import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_form.dart';

class AddEditTaskScreen extends StatelessWidget {
  const AddEditTaskScreen({
    super.key,
    this.isEditing = false,
    this.initialTitle = '',
    this.initialDescription = '',
    this.initialCategory = TaskCategory.personal,
    this.initialPriority = TaskPriority.none,
    this.initialDueDate,
  });

  final bool isEditing;
  final String initialTitle;
  final String initialDescription;
  final TaskCategory initialCategory;
  final TaskPriority initialPriority;
  final DateTime? initialDueDate;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(isEditing ? 'Edit Task' : 'New Task'),
        centerTitle: true,
      ),
      body: TaskForm(
        isEditing: isEditing,
        initialTitle: initialTitle,
        initialDescription: initialDescription,
        initialCategory: initialCategory,
        initialPriority: initialPriority,
        initialDueDate: initialDueDate,
        onSave: () => Navigator.of(context).pop(),
      ),
    );
  }
}
