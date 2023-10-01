import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/components/dialog_box.dart';
import 'package:to_do/components/todo_tile.dart';
import 'package:to_do/data/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToDoDB db = ToDoDB();

  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get("TODOLIST") == null) {
      db.initialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _myBox = Hive.box('my_box');

  final _controller = TextEditingController();

  void checkChange(bool? value, int index) {
    setState(() {
      db.toDo[index][1] = !db.toDo[index][1];
      db.updateData();
    });
  }

  void saveTask() {
    setState(() {
      db.toDo.add([_controller.text, false]);
      Navigator.of(context).pop();
      _controller.clear();
      db.updateData();
    });
  }

  void cancelTask() {
    setState(() {
      Navigator.of(context).pop();
      _controller.clear();
    });
  }

  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DBox(
            controller: _controller,
            onSave: saveTask,
            onCancel: cancelTask,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDo.removeAt(index);
      db.updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "TO DO",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(185, 33, 33, 33),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: db.toDo.length,
        itemBuilder: (context, index) {
          return ToDoTile(
              taskName: db.toDo[index][0],
              taskCompleted: db.toDo[index][1],
              onChanged: (value) => checkChange(value, index),
              deleteTile: (context) => deleteTask(index));
        },
      ),
    );
  }
}
