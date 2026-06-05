import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.deepPurple.shade200),
          const SizedBox(height: 10),
          Text(
            message,
            style: TextStyle(fontSize: 18, color: Colors.deepPurple.shade300),
          ),
        ],
      ),
    );
  }
}
