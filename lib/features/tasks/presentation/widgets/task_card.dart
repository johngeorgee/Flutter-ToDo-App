import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_spacing.dart';
import 'package:todo_app/features/tasks/presentation/widgets/category_chip.dart';
import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';
import 'package:todo_app/shared/widgets/animated_checkbox.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.priority = TaskPriority.none,
    this.category,
    this.dueDate,
    this.onTap,
    this.onCheckboxChanged,
  });

  final String title;
  final String? description;
  final bool isCompleted;
  final TaskPriority priority;
  final TaskCategory? category;
  final String? dueDate;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onCheckboxChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final priorityColor = PriorityBadge.colorFor(priority);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (priority != TaskPriority.none)
                Container(
                  width: 4,
                  color: priorityColor,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: AnimatedCheckbox(
                          value: isCompleted,
                          onChanged: onCheckboxChanged,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: textTheme.titleSmall?.copyWith(
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: isCompleted
                                    ? colorScheme.onSurfaceVariant
                                    : colorScheme.onSurface,
                              ),
                            ),
                            if (description != null) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                description!,
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                            const SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.xs,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                if (priority != TaskPriority.none)
                                  PriorityBadge(priority: priority),
                                if (category != null)
                                  CategoryChip(
                                    category: category!,
                                    showIcon: true,
                                  ),
                                if (dueDate != null)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.event_rounded,
                                        size: 14,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: AppSpacing.xs),
                                      Text(
                                        dueDate!,
                                        style: textTheme.labelSmall?.copyWith(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
