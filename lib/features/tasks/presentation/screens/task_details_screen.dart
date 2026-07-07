// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/config/theme/app_spacing.dart';
import 'package:todo_app/core/widgets/app_scaffold.dart';
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
import 'package:todo_app/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_app/shared/widgets/confirmation_dialog.dart';

class TaskDetailsScreen extends ConsumerWidget {
  const TaskDetailsScreen({
    super.key,
    required this.task,
  });

  final Task task;

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await ConfirmationDialog.show(
      context,
      title: 'Delete Task',
      message:
          'Are you sure you want to delete this task? This action cannot be undone.',
      confirmLabel: 'Delete',
      cancelLabel: 'Cancel',
      isDestructive: true,
      icon: Icons.delete_outline_rounded,
    );

    if (confirmed != true) return;

    await ref.read(taskNotifierProvider.notifier).delete(task.id);

    if (!context.mounted) return;

    Navigator.pop(context);
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.editTask,
      arguments: task,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit',
            onPressed: () => _navigateToEdit(context),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline_rounded,
              color: colorScheme.error,
            ),
            tooltip: 'Delete',
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: textTheme.headlineMedium?.copyWith(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: task.isCompleted
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                _StatusChip(isCompleted: task.isCompleted),
              ],
            ),

            if (task.description.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Description',
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                task.description,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.5,
                ),
              ),
            ],

            const SizedBox(height: AppSpacing.xxl),

            _DetailTile(
              icon: Icons.folder_outlined,
              label: 'Category',
              value: task.categoryId ?? 'No Category',
            ),

            if (task.dueDate != null)
              _DetailTile(
                icon: Icons.event,
                label: 'Due Date',
                value: task.dueDate.toString(),
              ),

            const SizedBox(height: AppSpacing.xxxl),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _navigateToEdit(context),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _confirmDelete(context, ref),
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.errorContainer,
                      foregroundColor: colorScheme.onErrorContainer,
                    ),
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.isCompleted,
  });

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isCompleted
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Text(
        isCompleted ? 'Done' : 'Active',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isCompleted
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              icon,
              size: AppSpacing.iconSm,
              color: valueColor ?? colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: textTheme.titleSmall?.copyWith(
                    color: valueColor ?? colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}