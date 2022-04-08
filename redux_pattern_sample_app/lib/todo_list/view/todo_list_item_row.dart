import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_pattern_sample_app/model/todo_list_item.dart';
import 'package:redux_pattern_sample_app/reducer/todo_list_reducer.dart';
import 'package:redux_pattern_sample_app/state/app_state.dart';

class TodoListItemRow extends StatelessWidget {
  final TodoListItem item;
  final int index;

  const TodoListItemRow({required this.index, required this.item, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: item.isChecked,
          onChanged: (isNowChecked) {
            if (isNowChecked ?? false) {
              StoreProvider.of<AppState>(context)
                  .dispatch(CheckTodoListItemAction(index));
            } else {
              StoreProvider.of<AppState>(context)
                  .dispatch(UncheckTodoListItemAction(index));
            }
          },
        ),
        Expanded(child: Text(item.text)),
        MaterialButton(
          key: Key('remove_button_$index'),
          child: const Text('X'),
          onPressed: () {
            StoreProvider.of<AppState>(context)
                .dispatch(RemoveTodoListItemAction(index));
          },
        )
      ],
    );
  }
}
