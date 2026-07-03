import 'package:flutter/material.dart';
import 'package:todo_app/config/routes/app_router.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/config/theme/app_theme.dart';
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
