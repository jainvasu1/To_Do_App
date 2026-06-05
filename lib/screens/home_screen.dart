import 'package:flutter/material.dart';
import '../models/task.dart';
import 'all_tasks_screen.dart';
import 'completed_tasks_screen.dart';
import 'pending_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Task> tasks = [];

  void openAddTaskDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();

    String status = "Pending";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: status,
                items: ["Pending", "Completed"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  status = value!;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isEmpty) return;

                setState(() {
                  tasks.add(
                    Task(
                      title: titleController.text,
                      description: descController.text,
                      isCompleted: status == "Completed",
                    ),
                  );
                });

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      AllTasksScreen(tasks: tasks, onDelete: deleteTask, onToggle: toggleTask),
      CompletedTasksScreen(tasks: tasks),
      PendingTasksScreen(tasks: tasks),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Todo App ")),

      body: screens[currentIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: openAddTaskDialog,
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "All"),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.pending), label: "Pending"),
        ],
      ),
    );
  }
}
