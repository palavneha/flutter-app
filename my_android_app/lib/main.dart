
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TodoApp(),
  ));
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final controller = TextEditingController();
  final List<String> tasks = [];
  final List<bool> completed = [];

  void addTask() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      tasks.add(controller.text.trim());
      completed.add(false);
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Enter a task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => addTask(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addTask,
              child: const Text('Add Task'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      tasks[index],
                      style: TextStyle(
                        decoration: completed[index]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    value: completed[index],
                    onChanged: (value) {
                      setState(() {
                        completed[index] = value ?? false;
                      });
                    },
                    secondary: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          tasks.removeAt(index);
                          completed.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
