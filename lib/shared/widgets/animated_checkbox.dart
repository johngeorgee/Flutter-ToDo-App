import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_spacing.dart';

class AnimatedCheckbox extends StatefulWidget {
  const AnimatedCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.size = 24,
    this.activeColor,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size;
  final Color? activeColor;

  @override
  State<AnimatedCheckbox> createState() => _AnimatedCheckboxState();
}

class _AnimatedCheckboxState extends State<AnimatedCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.value) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(AnimatedCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0).then((_) {
      if (mounted) _controller.reverse();
    });
    widget.onChanged?.call(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activeColor = widget.activeColor ?? colorScheme.primary;

    return GestureDetector(
      onTap: widget.onChanged != null ? _handleTap : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.value
                ? activeColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(
              color: widget.value
                  ? activeColor
                  : colorScheme.outline,
              width: 2,
            ),
          ),
          child: widget.value
              ? Icon(
                  Icons.check_rounded,
                  size: widget.size * 0.65,
                  color: colorScheme.onPrimary,
                )
              : null,
        ),
      ),
    );
  }
}
