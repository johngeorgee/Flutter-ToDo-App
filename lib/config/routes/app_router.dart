import 'package:flutter/material.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:todo_app/features/tasks/presentation/screens/add_edit_task_screen.dart';
import 'package:todo_app/features/tasks/presentation/screens/home_screen.dart';
import 'package:todo_app/features/tasks/presentation/screens/search_screen.dart';
import 'package:todo_app/features/tasks/presentation/screens/task_details_screen.dart';
import 'package:todo_app/features/tasks/presentation/widgets/category_chip.dart';
import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _fadeRoute(const HomeScreen(), settings);
      case AppRoutes.addTask:
        return _slideUpRoute(
          const AddEditTaskScreen(isEditing: false),
          settings,
        );
      case AppRoutes.editTask:
        final args = settings.arguments as Map<String, dynamic>?;
        return _slideUpRoute(
          AddEditTaskScreen(
            isEditing: true,
            initialTitle: args?['title'] as String? ?? '',
            initialDescription: args?['description'] as String? ?? '',
            initialCategory:
                args?['category'] as TaskCategory? ?? TaskCategory.personal,
            initialPriority:
                args?['priority'] as TaskPriority? ?? TaskPriority.none,
            initialDueDate: args?['dueDate'] as DateTime?,
          ),
          settings,
        );
      case AppRoutes.taskDetails:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return _slideRoute(
          TaskDetailsScreen(
            title: args['title'] as String? ?? 'Task',
            description: args['description'] as String? ?? '',
            category: args['category'] as TaskCategory? ?? TaskCategory.personal,
            priority: args['priority'] as TaskPriority? ?? TaskPriority.none,
            dueDate: args['dueDate'] as String?,
            isCompleted: args['isCompleted'] as bool? ?? false,
          ),
          settings,
        );
      case AppRoutes.search:
        return _fadeRoute(const SearchScreen(), settings);
      case AppRoutes.settings:
        return _slideRoute(const SettingsScreen(), settings);
      default:
        return _fadeRoute(const HomeScreen(), settings);
    }
  }

  static PageRouteBuilder<T> _fadeRoute<T>(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  static PageRouteBuilder<T> _slideRoute<T>(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
    );
  }

  static PageRouteBuilder<T> _slideUpRoute<T>(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
