import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/theme/app_spacing.dart';
import 'package:todo_app/features/categories/presentation/providers/category_providers.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_app/features/tasks/presentation/providers/task_provider.dart';
//import 'package:todo_app/features/tasks/presentation/widgets/category_chip.dart';
import 'package:todo_app/features/tasks/presentation/widgets/date_picker_field.dart';
import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';
//import 'package:todo_app/features/tasks/presentation/providers/task_notifier.dart';
import 'package:todo_app/features/tasks/domain/entities/task_priority.dart';
class TaskForm extends ConsumerStatefulWidget {
  const TaskForm({
    super.key,
    this.task ,
    this.onSave
  });

  final Task? task;
  final VoidCallback? onSave;

  @override
  ConsumerState<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends ConsumerState<TaskForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  String?  _selectedCategoryId;
  late TaskPriority _selectedPriority;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.task?.title ?? '');

    _descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
    _selectedCategoryId = widget.task?.categoryId ?? '';
    _selectedPriority = widget.task?.priority ?? TaskPriority.none;
    _selectedDate = widget.task?.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  Future<void> _saveTask() async {

  if (_titleController.text.trim().isEmpty) {

    
    return;
  }
  
  try {
    if (widget.task == null) {

  await ref.read(taskNotifierProvider.notifier).create(
    title: _titleController.text.trim(),
    description: _descriptionController.text.trim(),
    categoryId: _selectedCategoryId,
    priority: _selectedPriority,
    dueDate: _selectedDate,
  );

} else {

  await ref.read(taskNotifierProvider.notifier).update(
    
    id: widget.task!.id,
    title: _titleController.text.trim(),
    description: _descriptionController.text.trim(),
    categoryId: _selectedCategoryId,
    priority: _selectedPriority,
    dueDate: _selectedDate,
    isCompleted: widget.task!.isCompleted,
    createdAt: widget.task!.createdAt,
  );
}

    if (!mounted) return;

    widget.onSave?.call();
    Navigator.pop(context);
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
 
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final categories = ref.watch(categoriesStreamProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            
            style: textTheme.headlineSmall,
            decoration: const InputDecoration(
              hintText: 'Task title',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: false,
              contentPadding: EdgeInsets.zero,
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _descriptionController,
            onChanged: (value){

            },
            maxLines: 4,
            minLines: 2,
            decoration: InputDecoration(
              hintText: 'Add description...',
              alignLabelWithHint: true,
              filled: true,
              fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: AppSpacing.xl),
          const _SectionLabel(label: 'Category'),
          const SizedBox(height: AppSpacing.sm),
          categories.when(
            data: (list){
              return Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: list.map((category){
                  return ChoiceChip(
                    label: Text(category.name), 
                    selected: _selectedCategoryId == category.id,
                    avatar: CircleAvatar(
                      radius: 8,
                      backgroundColor: category.color,
                    ),
                    onSelected: (_){
                      setState(() {
                        _selectedCategoryId = category.id;
                      });
                    },
                    );
                }).toList(),
              );
            }, 
            error: (_, _) => const SizedBox(), 
            loading: ()=> const CircularProgressIndicator()),
          const SizedBox(height: AppSpacing.xl),
          const _SectionLabel(label: 'Priority'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: TaskPriority.values.map((priority) {
              final isSelected = _selectedPriority == priority;
              final color = PriorityBadge.colorFor(priority);
              return FilterChip(
                label: Text(PriorityBadge.labelFor(priority)),
                selected: isSelected,
                onSelected: (_) =>
                    setState(() => _selectedPriority = priority),
                avatar: Icon(
                  PriorityBadge.iconFor(priority),
                  size: 16,
                  color: isSelected ? color : colorScheme.onSurfaceVariant,
                ),
                selectedColor: color.withValues(alpha: 0.2),
                checkmarkColor: color,
                showCheckmark: isSelected,
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          DatePickerField(
            selectedDate: _selectedDate,
            onDateSelected: (date) => setState(() => _selectedDate = date),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          FilledButton(
            onPressed: (){

              _saveTask();},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Text(widget.task == null ? 'Create Task' : 'Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
