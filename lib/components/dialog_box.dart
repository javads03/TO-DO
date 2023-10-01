import 'package:flutter/material.dart';
import 'package:to_do/components/my_button.dart';

// ignore: must_be_immutable
class DBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(252, 31, 31, 31),
      content: Container(
          height: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'Add a new task',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                ),
                style: TextStyle(color: Color.fromARGB(255, 254, 254, 254)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(text: "Save", onPressed: onSave),
                  const SizedBox(
                    width: 8,
                  ),
                  MyButton(text: "Cancel", onPressed: onCancel),
                ],
              )
            ],
          )),
    );
  }
}
