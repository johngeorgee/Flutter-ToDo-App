import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_colors.dart';
import 'package:todo_app/config/theme/app_spacing.dart';

import 'package:todo_app/features/tasks/domain/entities/task_priority.dart';

class PriorityBadge extends StatelessWidget {
  const PriorityBadge({
    super.key,
    required this.priority,
    this.compact = false,
  });

  final TaskPriority priority;
  final bool compact;

  static Color colorFor(TaskPriority priority) {
    return switch (priority) {
      TaskPriority.high => AppColors.priorityHigh,
      TaskPriority.medium => AppColors.priorityMedium,
      TaskPriority.low => AppColors.priorityLow,
      TaskPriority.none => AppColors.priorityNone,
    };
  }

  static String labelFor(TaskPriority priority) {
    return switch (priority) {
      TaskPriority.high => 'High',
      TaskPriority.medium => 'Medium',
      TaskPriority.low => 'Low',
      TaskPriority.none => 'None',
    };
  }

  static IconData iconFor(TaskPriority priority) {
    return switch (priority) {
      TaskPriority.high => Icons.flag_rounded,
      TaskPriority.medium => Icons.outlined_flag_rounded,
      TaskPriority.low => Icons.low_priority_rounded,
      TaskPriority.none => Icons.remove_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = colorFor(priority);
    final label = labelFor(priority);

    if (compact) {
      return Icon(
        iconFor(priority),
        size: AppSpacing.iconSm,
        color: color,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconFor(priority),
            size: 14,
            color: color,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
