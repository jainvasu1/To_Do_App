import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const String key = 'tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> taskList = tasks.map((task) {
        return jsonEncode({
          'title': task.title,
          'description': task.description,
          'isCompleted': task.isCompleted,
        });
      }).toList();

      await prefs.setStringList(key, taskList);
    } catch (e) {
      print('Error saving tasks: $e');
    }
  }

  static Future<List<Task>> loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String>? storedTasks = prefs.getStringList(key);

      if (storedTasks == null) {
        return [];
      }

      return storedTasks.map((taskString) {
        final data = jsonDecode(taskString);

        return Task(
          title: data['title'],
          description: data['description'],
          isCompleted: data['isCompleted'],
        );
      }).toList();
    } catch (e) {
      print('Error loading tasks: $e');
      return [];
    }
  }
}
