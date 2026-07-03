import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_spacing.dart';
import 'package:todo_app/features/tasks/presentation/widgets/category_chip.dart';
import 'package:todo_app/features/tasks/presentation/widgets/date_picker_field.dart';
import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({
    super.key,
    this.initialTitle = '',
    this.initialDescription = '',
    this.initialCategory = TaskCategory.personal,
    this.initialPriority = TaskPriority.none,
    this.initialDueDate,
    this.onSave,
    this.isEditing = false,
  });

  final String initialTitle;
  final String initialDescription;
  final TaskCategory initialCategory;
  final TaskPriority initialPriority;
  final DateTime? initialDueDate;
  final VoidCallback? onSave;
  final bool isEditing;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late TaskCategory _selectedCategory;
  late TaskPriority _selectedPriority;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
    _selectedCategory = widget.initialCategory;
    _selectedPriority = widget.initialPriority;
    _selectedDate = widget.initialDueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
          _SectionLabel(label: 'Category'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: TaskCategory.values.map((category) {
              return CategoryChip(
                category: category,
                selected: _selectedCategory == category,
                onTap: () => setState(() => _selectedCategory = category),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionLabel(label: 'Priority'),
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
            onPressed: widget.onSave,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Text(widget.isEditing ? 'Save Changes' : 'Create Task'),
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
