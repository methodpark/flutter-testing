import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_pattern_sample_app/reducer/todo_list_reducer.dart';
import 'package:redux_pattern_sample_app/state/app_state.dart';

class AddTodoListItemRow extends StatelessWidget {
  final textController = TextEditingController();

  AddTodoListItemRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.blue.shade100,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              key: const Key('add_text_field'),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
              controller: textController,
            ),
          ),
          MaterialButton(
            child: const Text('Add'),
            key: const Key('add_button'),
            onPressed: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(AddTodoListItemAction(textController.text));
            },
          )
        ],
      ),
    );
  }
}
