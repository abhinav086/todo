// todo_app.dart
//Abhinav's todo list application
import 'package:flutter/material.dart';
import 'task.dart';

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Task> tasks = [];
  List<Task> completedTasks = [];

  TextEditingController taskController = TextEditingController();

  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(name: taskController.text));
        taskController.clear();
      });
    }
  }

  void completeTask(Task task) {
    setState(() {
      task.isCompleted = true;
      completedTasks.add(task);
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List',
          style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                tasks.clear();
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[350],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Completed Tasks', style: TextStyle(color: Colors.white)),
            ),
            for (Task task in completedTasks)
              ListTile(
                title: Text(task.name),
                leading: Checkbox(
                  value: true,
                  onChanged: null,
                ),
              ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: 'Write here...',
                hintStyle:TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addTask,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                return ListTile(
                  title: Text(task.name),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      completeTask(task);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
