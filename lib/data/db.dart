import 'package:hive_flutter/hive_flutter.dart';

class ToDoDB {
  List toDo = [];
  final _myBox = Hive.box('my_box');

  void initialData() {
    toDo = [
      ['Do Exercise', false]
    ];
  }

  void loadData() {
    toDo = _myBox.get('TODOLIST');
  }

  void updateData() {
    _myBox.put('TODOLIST', toDo);
  }
}
