import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_colors.dart';
import 'package:todo_app/config/theme/app_spacing.dart';

enum TaskCategory { work, personal, shopping, health, other }

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    this.selected = false,
    this.onTap,
    this.showIcon = true,
  });

  final TaskCategory category;
  final bool selected;
  final VoidCallback? onTap;
  final bool showIcon;

  static Color colorFor(TaskCategory category) {
    return switch (category) {
      TaskCategory.work => AppColors.categoryWork,
      TaskCategory.personal => AppColors.categoryPersonal,
      TaskCategory.shopping => AppColors.categoryShopping,
      TaskCategory.health => AppColors.categoryHealth,
      TaskCategory.other => AppColors.categoryOther,
    };
  }

  static String labelFor(TaskCategory category) {
    return switch (category) {
      TaskCategory.work => 'Work',
      TaskCategory.personal => 'Personal',
      TaskCategory.shopping => 'Shopping',
      TaskCategory.health => 'Health',
      TaskCategory.other => 'Other',
    };
  }

  static IconData iconFor(TaskCategory category) {
    return switch (category) {
      TaskCategory.work => Icons.work_outline_rounded,
      TaskCategory.personal => Icons.person_outline_rounded,
      TaskCategory.shopping => Icons.shopping_bag_outlined,
      TaskCategory.health => Icons.favorite_outline_rounded,
      TaskCategory.other => Icons.label_outline_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = colorFor(category);
    final label = labelFor(category);
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: selected
          ? color.withValues(alpha: 0.2)
          : colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showIcon) ...[
                Icon(
                  iconFor(category),
                  size: 16,
                  color: selected ? color : colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: selected ? color : colorScheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
