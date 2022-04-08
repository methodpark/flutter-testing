import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_model.dart';
import 'package:bloc_pattern_sample_app/todo_list/todo_list.dart';
import 'package:flutter/material.dart';

class TodoListItemRow extends StatelessWidget {
  final TodoListItem item;
  final VoidCallback removeItemPressed;
  final UnaryCallback<bool> changeCheckedState;

  const TodoListItemRow({
    Key? key,
    required this.item,
    required this.removeItemPressed,
    required this.changeCheckedState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: item.isChecked,
          onChanged: (isNowChecked) => changeCheckedState(isNowChecked ?? false),
        ),
        Expanded(child: Text(item.text)),
        MaterialButton(
          child: const Text('X'),
          onPressed: removeItemPressed,
        )
      ],
    );
  }
}
