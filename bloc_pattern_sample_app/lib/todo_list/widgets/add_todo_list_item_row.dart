import 'package:bloc_pattern_sample_app/todo_list/todo_list.dart';
import 'package:flutter/material.dart';

class AddTodoListItemRow extends StatelessWidget {
  final textController = TextEditingController();
  final UnaryCallback<String> addButtonPressed;

  AddTodoListItemRow({Key? key, required this.addButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.blue.shade100,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
              controller: textController,
            ),
          ),
          MaterialButton(
            child: const Text('Add'),
            onPressed: () => addButtonPressed(textController.text),
          )
        ],
      ),
    );
  }
}
