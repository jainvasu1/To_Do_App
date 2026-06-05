import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../widgets/empty_state.dart';

class AllTasksScreen extends StatelessWidget {
  final List<Task> tasks;
  final Function(int) onDelete;
  final Function(int) onToggle;

  const AllTasksScreen({
    super.key,
    required this.tasks,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    //
    if (tasks.isEmpty) {
      return const EmptyState(message: "No tasks yet");
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },

      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
            onDelete: () => onDelete(index),
            onToggle: () => onToggle(index),
          );
        },
      ),
    );
  }
}
