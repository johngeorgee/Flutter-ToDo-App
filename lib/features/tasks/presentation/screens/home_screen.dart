// ignore_for_file: unused_field, unused_element, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/config/theme/app_spacing.dart';
import 'package:todo_app/core/widgets/app_scaffold.dart';
import 'package:todo_app/features/categories/presentation/providers/category_providers.dart';
///import 'package:todo_app/features/tasks/presentation/providers/task_form_provider.dart';
import 'package:todo_app/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_app/features/tasks/presentation/widgets/category_chip.dart';
import 'package:todo_app/features/tasks/presentation/widgets/empty_state.dart';
import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_card.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_tile.dart';
import 'package:todo_app/shared/widgets/app_search_bar.dart';
import 'package:todo_app/shared/widgets/custom_bottom_sheet.dart';
import 'package:todo_app/shared/widgets/section_header.dart';
import 'package:todo_app/features/tasks/domain/entities/task_priority.dart';
//import 'package:todo_app/features/tasks/presentation/providers/task_list_provider.dart' hide tasksStreamProvider;
import 'package:todo_app/features/tasks/domain/entities/task_entity.dart';
//import 'package:todo_app/features/tasks/presentation/providers/task_notifier.dart';
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends ConsumerState<HomeScreen> {
  final bool _showCompleted = true;
  Future<void> _toggleTask(Task task) async {
  await ref.read(taskNotifierProvider.notifier).toggleCompleted(task);
}
  

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  void _openTaskDetails(Task task) {
    Navigator.of(context).pushNamed(
      AppRoutes.taskDetails,
      arguments: task
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
    final categories = ref.watch(categoriesStreamProvider);
    final taskAsync = ref.watch(tasksStreamProvider);
    
    return taskAsync.when(
      loading: () => const Center(
    child: CircularProgressIndicator(),
  ),

  error: (error, stack) => Center(
    child: Text(error.toString()),
  ),
      data: (tasks) { 
        final hasTasks = tasks.isNotEmpty;
        final todayTasks = tasks.where((task) {
  if (task.isCompleted) return false;

  if (task.dueDate == null) return false;

  final now = DateTime.now();

  return task.dueDate!.year == now.year &&
      task.dueDate!.month == now.month &&
      task.dueDate!.day == now.day;
}).toList();

final upcomingTasks = tasks.where((task) {
  return !task.isCompleted &&
      (task.dueDate == null ||
          task.dueDate!.isAfter(DateTime.now()));
}).toList();

final completedTasks =
    tasks.where((task) => task.isCompleted).toList();
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
                if(upcomingTasks.isEmpty && todayTasks.isEmpty && completedTasks.isNotEmpty)
                    const SizedBox(
                    height: 400,
                    child: EmptyState(
                      title: 'No upcoming tasks yet',
                      subtitle:
                          'You have completed all your tasks for now. Tap the button below to create a new task and stay productive.',
                      icon: Icons.checklist_rounded,
                      actionLabel: 'Create Task',
                    ),
                  ),
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
                  if (todayTasks.isNotEmpty) ...[
                    SectionHeader(
                      title: 'Today',
                      subtitle: '${todayTasks.length} tasks',
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
                            for (var i = 0; i < todayTasks.length; i++)
                              TaskTile(
                                title: todayTasks[i].title,
                                subtitle: todayTasks[i].description,
                                isCompleted: todayTasks[i].isCompleted,
                                priority: todayTasks[i].priority,
                                category: null,
                                dueDate: todayTasks[i].dueDate?.toString(),
                                showDivider: i < todayTasks.length - 1,
                                onTap: () => _openTaskDetails(todayTasks[i]),
                                onCheckboxChanged: (_) {
                                  ref.read(taskNotifierProvider.notifier)
                                  .toggleCompleted(todayTasks[i]);
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (upcomingTasks.isNotEmpty) ...[
                    SectionHeader(
                      title: 'Upcoming',
                      subtitle: '${upcomingTasks.length} tasks',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        children: upcomingTasks
                            .map(
                              (task) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.sm,
                                ),
                                child: TaskCard(
                                  title: task.title,
                                  description: task.description,
                                  priority: task.priority,
                                  category: null,
                                  dueDate: task.dueDate?.toString(),
                                  onTap: () => _openTaskDetails(task),
                                  onCheckboxChanged: (_) {
                                  ref.read(taskNotifierProvider.notifier)
                                  .toggleCompleted(task);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],

                  
  
                ],
              ],
            ),
          ),
        ],
      );
    
    },
    );
  }



}