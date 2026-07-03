import 'package:flutter/material.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/config/theme/app_spacing.dart';
import 'package:todo_app/core/widgets/app_scaffold.dart';
import 'package:todo_app/features/tasks/presentation/widgets/category_chip.dart';
import 'package:todo_app/features/tasks/presentation/widgets/empty_state.dart';
import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_card.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_tile.dart';
import 'package:todo_app/shared/widgets/app_search_bar.dart';
import 'package:todo_app/shared/widgets/custom_bottom_sheet.dart';
import 'package:todo_app/shared/widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCompleted = true;

  // Mock preview data
  static const _todayTasks = [
    _MockTask(
      title: 'Review project proposal',
      description: 'Go through the Q3 roadmap document',
      priority: TaskPriority.high,
      category: TaskCategory.work,
      dueDate: 'Today, 5:00 PM',
    ),
    _MockTask(
      title: 'Morning workout',
      description: '30 min cardio + stretching',
      priority: TaskPriority.medium,
      category: TaskCategory.health,
      dueDate: 'Today, 7:00 AM',
      isCompleted: true,
    ),
  ];

  static const _upcomingTasks = [
    _MockTask(
      title: 'Buy groceries',
      description: 'Milk, eggs, bread, vegetables',
      priority: TaskPriority.low,
      category: TaskCategory.shopping,
      dueDate: 'Tomorrow',
    ),
    _MockTask(
      title: 'Call dentist',
      priority: TaskPriority.none,
      category: TaskCategory.health,
      dueDate: 'Jul 5',
    ),
    _MockTask(
      title: 'Prepare presentation slides',
      description: 'Team sync on Friday',
      priority: TaskPriority.high,
      category: TaskCategory.work,
      dueDate: 'Jul 6',
    ),
  ];

  static const _completedTasks = [
    _MockTask(
      title: 'Pay electricity bill',
      category: TaskCategory.personal,
      dueDate: 'Yesterday',
      isCompleted: true,
    ),
    _MockTask(
      title: 'Reply to client email',
      category: TaskCategory.work,
      dueDate: 'Jul 1',
      isCompleted: true,
    ),
  ];

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  void _openTaskDetails(_MockTask task) {
    Navigator.of(context).pushNamed(
      AppRoutes.taskDetails,
      arguments: {
        'title': task.title,
        'description': task.description ?? '',
        'category': task.category,
        'priority': task.priority,
        'dueDate': task.dueDate,
        'isCompleted': task.isCompleted,
      },
    );
  }

  void _showFilterSheet() {
    CustomBottomSheet.show<void>(
      context,
      title: 'Filter Tasks',
      subtitle: 'Refine your task list',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Priority',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            children: TaskPriority.values.map((p) {
              return FilterChip(
                label: Text(PriorityBadge.labelFor(p)),
                selected: false,
                onSelected: (_) => Navigator.pop(context),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Category',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: TaskCategory.values.map((c) {
              return CategoryChip(
                category: c,
                selected: false,
                onTap: () => Navigator.pop(context),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasTasks = _todayTasks.isNotEmpty ||
        _upcomingTasks.isNotEmpty ||
        _completedTasks.isNotEmpty;

    return AppSliverScaffold(
      
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          elevation: 0,
          backgroundColor: colorScheme.surface,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting(),
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                'My Tasks',
                style: textTheme.headlineSmall,
              ),
            ],
          ),
          
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.sm),
              AppSearchBar(
                readOnly: true,
                showFilter: true,
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.search),
                onFilterTap: _showFilterSheet,
              ),
              const SizedBox(height: AppSpacing.lg),
              if (!hasTasks)
                const SizedBox(
                  height: 400,
                  child: EmptyState(
                    title: 'No tasks yet',
                    subtitle:
                        'Tap the button below to create your first task and stay organized.',
                    icon: Icons.checklist_rounded,
                    actionLabel: 'Create Task',
                  ),
                )
              else ...[
                if (_todayTasks.isNotEmpty) ...[
                  SectionHeader(
                    title: 'Today',
                    subtitle: '${_todayTasks.length} tasks',
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text('See all'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Card(
                      child: Column(
                        children: [
                          for (var i = 0; i < _todayTasks.length; i++)
                            TaskTile(
                              title: _todayTasks[i].title,
                              subtitle: _todayTasks[i].description,
                              isCompleted: _todayTasks[i].isCompleted,
                              priority: _todayTasks[i].priority,
                              category: _todayTasks[i].category,
                              dueDate: _todayTasks[i].dueDate,
                              showDivider: i < _todayTasks.length - 1,
                              onTap: () => _openTaskDetails(_todayTasks[i]),
                              onCheckboxChanged: (_) {},
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (_upcomingTasks.isNotEmpty) ...[
                  SectionHeader(
                    title: 'Upcoming',
                    subtitle: '${_upcomingTasks.length} tasks',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Column(
                      children: _upcomingTasks
                          .map(
                            (task) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: TaskCard(
                                title: task.title,
                                description: task.description,
                                priority: task.priority,
                                category: task.category,
                                dueDate: task.dueDate,
                                onTap: () => _openTaskDetails(task),
                                onCheckboxChanged: (_) {},
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
                SectionHeader(
                  title: 'Completed',
                  subtitle: '${_completedTasks.length} tasks',
                  trailing: IconButton(
                    icon: Icon(
                      _showCompleted
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                    ),
                    onPressed: () =>
                        setState(() => _showCompleted = !_showCompleted),
                  ),
                ),
                if (_showCompleted)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Card(
                      child: Column(
                        children: [
                          for (var i = 0; i < _completedTasks.length; i++)
                            TaskTile(
                              title: _completedTasks[i].title,
                              isCompleted: true,
                              category: _completedTasks[i].category,
                              dueDate: _completedTasks[i].dueDate,
                              showDivider: i < _completedTasks.length - 1,
                              onTap: () =>
                                  _openTaskDetails(_completedTasks[i]),
                              onCheckboxChanged: (_) {},
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MockTask {
  const _MockTask({
    required this.title,
    this.description,
    this.priority = TaskPriority.none,
    this.category = TaskCategory.personal,
    this.dueDate,
    this.isCompleted = false,
  });

  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskCategory category;
  final String? dueDate;
  final bool isCompleted;
}
