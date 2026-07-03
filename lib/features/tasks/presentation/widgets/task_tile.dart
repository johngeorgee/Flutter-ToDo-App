import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_spacing.dart';
import 'package:todo_app/features/tasks/presentation/widgets/category_chip.dart';
import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';
import 'package:todo_app/shared/widgets/animated_checkbox.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.title,
    this.subtitle,
    this.isCompleted = false,
    this.priority = TaskPriority.none,
    this.category,
    this.dueDate,
    this.onTap,
    this.onCheckboxChanged,
    this.showDivider = true,
  });

  final String title;
  final String? subtitle;
  final bool isCompleted;
  final TaskPriority priority;
  final TaskCategory? category;
  final String? dueDate;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onCheckboxChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
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
                        style: textTheme.bodyLarge?.copyWith(
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: isCompleted
                              ? colorScheme.onSurfaceVariant
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null ||
                          dueDate != null ||
                          category != null ||
                          priority != TaskPriority.none) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            if (priority != TaskPriority.none)
                              PriorityBadge(
                                priority: priority,
                                compact: true,
                              ),
                            if (category != null) ...[
                              if (priority != TaskPriority.none)
                                const SizedBox(width: AppSpacing.sm),
                              Icon(
                                CategoryChip.iconFor(category!),
                                size: 14,
                                color: CategoryChip.colorFor(category!),
                              ),
                            ],
                            if (dueDate != null) ...[
                              const SizedBox(width: AppSpacing.sm),
                              Icon(
                                Icons.schedule_rounded,
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
                          ],
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            subtitle!,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            indent: AppSpacing.lg + 24 + AppSpacing.md,
            endIndent: AppSpacing.lg,
            height: 1,
          ),
      ],
    );
  }
}
