import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../widgets/empty_state.dart';

class PendingTasksScreen extends StatelessWidget {
  final List<Task> tasks;

  const PendingTasksScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final pendingTasks = tasks.where((task) => !task.isCompleted).toList();

    if (pendingTasks.isEmpty) {
      return const EmptyState(message: "No pending tasks ");
    }

    return ListView.builder(
      itemCount: pendingTasks.length,
      itemBuilder: (context, index) {
        final task = pendingTasks[index];

        return TaskTile(task: task, onDelete: () {}, onToggle: () {});
      },
    );
  }
}
