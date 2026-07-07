import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_spacing.dart';

class UndoDeleteSnackBar extends SnackBar {
  UndoDeleteSnackBar({
    super.key,
    required String taskTitle,
    required VoidCallback onUndo,
    super.duration,
  }) : super(
          content: _UndoDeleteContent(taskTitle: taskTitle),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(AppSpacing.lg),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );

  static void show(
    BuildContext context, {
    required String taskTitle,
    required VoidCallback onUndo,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      UndoDeleteSnackBar(
        taskTitle: taskTitle,
        onUndo: onUndo,
      ),
    );
  }
}

class _UndoDeleteContent extends StatelessWidget {
  const _UndoDeleteContent({required this.taskTitle});

  final String taskTitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          Icons.delete_outline_rounded,
          size: AppSpacing.iconSm,
          color: colorScheme.inversePrimary,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            'Deleted "$taskTitle"',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Preview widget for design/documentation purposes.
class UndoDeleteSnackBarPreview extends StatelessWidget {
  const UndoDeleteSnackBarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(AppSpacing.lg),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.delete_outline_rounded,
            size: AppSpacing.iconSm,
            color: colorScheme.inversePrimary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Deleted "Buy groceries"',
              style: TextStyle(color: colorScheme.onInverseSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Undo',
              style: TextStyle(color: colorScheme.inversePrimary),
            ),
          ),
        ],
      ),
    );
  }
}
