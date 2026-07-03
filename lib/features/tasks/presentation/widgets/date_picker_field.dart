import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_spacing.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    super.key,
    this.selectedDate,
    this.onDateSelected,
    this.label = 'Due Date',
    this.hintText = 'No due date',
    this.showClear = true,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime?>? onDateSelected;
  final String label;
  final String hintText;
  final bool showClear;

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
      helpText: 'Select due date',
      cancelText: 'Cancel',
      confirmText: 'OK',
    );
    if (picked != null) {
      onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasDate = selectedDate != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Material(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: InkWell(
            onTap: () => _pickDate(context),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: AppSpacing.iconSm,
                    color: hasDate
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      hasDate ? _formatDate(selectedDate!) : hintText,
                      style: textTheme.bodyMedium?.copyWith(
                        color: hasDate
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  if (hasDate && showClear)
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        size: AppSpacing.iconSm,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () => onDateSelected?.call(null),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    )
                  else
                    Icon(
                      Icons.chevron_right_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
