import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/widgets/app_scaffold.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
//import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_form.dart';
//import 'package:todo_app/features/tasks/domain/entities/task_priority.dart';
class AddEditTaskScreen extends ConsumerStatefulWidget {
  const AddEditTaskScreen({
    super.key,
    this.task,
  });

  final Task? task;

  @override
  ConsumerState<AddEditTaskScreen> createState() =>
      _AddEditTaskScreenState();
}

class _AddEditTaskScreenState
    extends ConsumerState<AddEditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.task == null ? 'New Task' : 'Edit Task'),
        centerTitle: true,
      ),
      body: TaskForm(
        task: widget.task,
        onSave: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}