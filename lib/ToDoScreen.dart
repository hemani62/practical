import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}


class _ToDoScreenState extends State<ToDoScreen> {
  List<String> tasks = [];
  final TextEditingController addTaskController = TextEditingController();

  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      tasks.add(title);
    });
    addTaskController.clear();
  }


  void _addTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:const Text('Add a task to your list'),
        content: TextField(
          controller: addTaskController,
          decoration: const InputDecoration(hintText: 'Enter task here'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // tasks.add(addTaskController.text); // Replace 'New Task' with the entered task.
                _addTodoItem(addTaskController.text);
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editTask(int index, String currentTaskName) {
    // Create a TextEditingController and set the current task name as its initial value
    TextEditingController taskController = TextEditingController(text: currentTaskName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit a task in your list'),
        content: TextField(
          onChanged: (value) {
            // You can perform additional validation here if needed.
          },
          controller: taskController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tasks[index] = taskController.text; // Update the task name with the edited value.
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editTask(index,tasks[index]),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTask(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}







