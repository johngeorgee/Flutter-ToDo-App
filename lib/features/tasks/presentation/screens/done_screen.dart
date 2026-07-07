import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_card.dart';

class DoneScreen extends ConsumerWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Tasks"),
      ),
      body: tasksAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),

        error: (error, _) =>
            Center(child: Text(error.toString())),

        data: (tasks) {
          final doneTasks =
              tasks.where((task) => task.isCompleted).toList();

          if (doneTasks.isEmpty) {
            return const Center(
              child: Text("No completed tasks"),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: doneTasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final task = doneTasks[index];

              return TaskCard(
                title: task.title,
                description: task.description,
                isCompleted: task.isCompleted,
                priority: task.priority,

                
                category: null,

                dueDate: task.dueDate == null
                    ? null
                    : DateFormat('dd MMM yyyy').format(task.dueDate!),

                onCheckboxChanged: (_) {
                  ref
                      .read(taskNotifierProvider.notifier)
                      .toggleCompleted(task);
                },

                onTap: () {
                  // هنضيف الـ Details بعدين
                },
              );
            },
          );
        },
      ),
    );
  }
}