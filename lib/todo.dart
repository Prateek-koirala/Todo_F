import 'package:flutter/material.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final _controller = TextEditingController();
  List toDoList = [];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    String newTask = _controller.text.trim();
    if (newTask.isNotEmpty) {
      setState(() {
        toDoList.add([newTask, false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
    } else {
      // Show a snackbar or dialog indicating that the task name cannot be empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Add Task First.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DailogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            onUpdate: () {
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController editingController =
                      TextEditingController(text: toDoList[index][0]);
                  return AlertDialog(
                    backgroundColor: Colors.yellow[300],
                    title: Text('Edit Task'),
                    content: TextField(
                      controller: editingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Edit Task Name",
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          String editedTask = editingController.text.trim();
                          if (editedTask.isNotEmpty) {
                            setState(() {
                              toDoList[index][0] = editedTask;
                            });
                            Navigator.of(context).pop();
                          } else {
                            // Show a snackbar or dialog indicating that the task name cannot be empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Task name cannot be empty.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Text('Save'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
