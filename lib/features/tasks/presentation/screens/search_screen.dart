import 'package:flutter/material.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/config/theme/app_spacing.dart';
import 'package:todo_app/core/widgets/app_scaffold.dart';
import 'package:todo_app/features/tasks/presentation/widgets/category_chip.dart';
import 'package:todo_app/features/tasks/presentation/widgets/empty_state.dart';
//import 'package:todo_app/features/tasks/presentation/widgets/priority_badge.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_tile.dart';
import 'package:todo_app/shared/widgets/app_search_bar.dart';
import 'package:todo_app/shared/widgets/section_header.dart';
import 'package:todo_app/features/tasks/domain/entities/task_priority.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  static const _recentSearches = [
    'groceries',
    'presentation',
    'workout',
    'dentist',
  ];

  static const _allTasks = [
    _SearchResult(
      title: 'Buy groceries',
      category: TaskCategory.shopping,
      priority: TaskPriority.low,
      dueDate: 'Tomorrow',
    ),
    _SearchResult(
      title: 'Prepare presentation slides',
      category: TaskCategory.work,
      priority: TaskPriority.high,
      dueDate: 'Jul 6',
    ),
    _SearchResult(
      title: 'Morning workout',
      category: TaskCategory.health,
      priority: TaskPriority.medium,
      dueDate: 'Today',
      isCompleted: true,
    ),
    _SearchResult(
      title: 'Call dentist',
      category: TaskCategory.health,
      dueDate: 'Jul 5',
    ),
    _SearchResult(
      title: 'Review project proposal',
      category: TaskCategory.work,
      priority: TaskPriority.high,
      dueDate: 'Today',
    ),
  ];

  List<_SearchResult> get _filteredResults {
    if (_query.isEmpty) return [];
    final lower = _query.toLowerCase();
    return _allTasks
        .where((t) => t.title.toLowerCase().contains(lower))
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openTask(_SearchResult task) {
    Navigator.of(context).pushNamed(
      AppRoutes.taskDetails,
      arguments: {
        'title': task.title,
        'description': '',
        'category': task.category,
        'priority': task.priority,
        'dueDate': task.dueDate,
        'isCompleted': task.isCompleted,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredResults;
    final isSearching = _query.isNotEmpty;

    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Search'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSearchBar(
            controller: _controller,
            autofocus: true,
            margin: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            onChanged: (value) => setState(() => _query = value),
          ),
          Expanded(
            child: !isSearching
                ? _RecentSearches(
                    searches: _recentSearches,
                    onTap: (term) {
                      _controller.text = term;
                      setState(() => _query = term);
                    },
                    onClear: () => setState(() {}),
                  )
                : results.isEmpty
                    ? const EmptyState(
                        title: 'No results found',
                        subtitle:
                            'Try a different search term or check your spelling.',
                        icon: Icons.search_off_rounded,
                      )
                    : ListView(
                        children: [
                          SectionHeader(
                            title: 'Results',
                            subtitle: '${results.length} found',
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg,
                              AppSpacing.sm,
                              AppSpacing.lg,
                              AppSpacing.sm,
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            child: Column(
                              children: [
                                for (var i = 0; i < results.length; i++)
                                  TaskTile(
                                    title: results[i].title,
                                    isCompleted: results[i].isCompleted,
                                    priority: results[i].priority,
                                    category: results[i].category,
                                    dueDate: results[i].dueDate,
                                    showDivider: i < results.length - 1,
                                    onTap: () => _openTask(results[i]),
                                    onCheckboxChanged: (_) {},
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}

class _RecentSearches extends StatelessWidget {
  const _RecentSearches({
    required this.searches,
    required this.onTap,
    required this.onClear,
  });

  final List<String> searches;
  final ValueChanged<String> onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      children: [
        SectionHeader(
          title: 'Recent Searches',
          trailing: TextButton(
            onPressed: onClear,
            child: const Text('Clear'),
          ),
          padding: EdgeInsets.zero,
        ),
        const SizedBox(height: AppSpacing.sm),
        ...searches.map(
          (term) => ListTile(
            leading: Icon(
              Icons.history_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
            title: Text(term),
            trailing: Icon(
              Icons.north_west_rounded,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
            onTap: () => onTap(term),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}

class _SearchResult {
  const _SearchResult({
    required this.title,
    required this.category,
    this.priority = TaskPriority.none,
    this.dueDate,
    this.isCompleted = false,
  });

  final String title;
  final TaskCategory category;
  final TaskPriority priority;
  final String? dueDate;
  final bool isCompleted;
}
