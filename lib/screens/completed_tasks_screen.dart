import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../widgets/empty_state.dart';

class CompletedTasksScreen extends StatelessWidget {
  final List<Task> tasks;

  const CompletedTasksScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    if (completedTasks.isEmpty) {
      return const EmptyState(message: "No completed tasks ");
    }

    return ListView.builder(
      itemCount: completedTasks.length,
      itemBuilder: (context, index) {
        final task = completedTasks[index];

        return TaskTile(task: task, onDelete: () {}, onToggle: () {});
      },
    );
  }
}
