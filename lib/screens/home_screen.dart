import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/storage_service.dart';
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

  late Future<void> loadFuture;

  @override
  void initState() {
    super.initState();
    loadFuture = loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      tasks = await StorageService.loadTasks();
    } catch (e) {
      debugPrint("Load Error: $e");
    }
  }

  void openAddTaskDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    String status = "Pending";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Create Task"),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return Column(
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
                  isExpanded: true,
                  items: ["Pending", "Completed"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      status = value!;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (titleController.text.trim().isEmpty) return;

              setState(() {
                tasks.add(
                  Task(
                    title: titleController.text.trim(),
                    description: descController.text.trim(),
                    isCompleted: status == "Completed",
                  ),
                );
              });

              await StorageService.saveTasks(tasks);

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void deleteTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });

    await StorageService.saveTasks(tasks);
  }

  void toggleTask(int index) async {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });

    await StorageService.saveTasks(tasks);
  }

  void editTask(int index) {
    TextEditingController titleController = TextEditingController(
      text: tasks[index].title,
    );

    TextEditingController descController = TextEditingController(
      text: tasks[index].description,
    );

    String status = tasks[index].isCompleted ? "Completed" : "Pending";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Task"),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return Column(
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
                  isExpanded: true,
                  items: ["Pending", "Completed"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      status = value!;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() {
                tasks[index].title = titleController.text.trim();

                tasks[index].description = descController.text.trim();

                tasks[index].isCompleted = status == "Completed";
              });

              await StorageService.saveTasks(tasks);

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      AllTasksScreen(
        tasks: tasks,
        onDelete: deleteTask,
        onToggle: toggleTask,
        onEdit: editTask,
      ),
      CompletedTasksScreen(tasks: tasks),
      PendingTasksScreen(tasks: tasks),
    ];

    return FutureBuilder(
      future: loadFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text("Todo App"), centerTitle: true),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.done),
                label: "Completed",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pending),
                label: "Pending",
              ),
            ],
          ),
        );
      },
    );
  }
}
