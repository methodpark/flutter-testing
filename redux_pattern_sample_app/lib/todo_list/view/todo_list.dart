import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_pattern_sample_app/state/app_state.dart';
import 'package:redux_pattern_sample_app/todo_list/view/add_todo_list_item_row.dart';
import 'package:redux_pattern_sample_app/todo_list/view/todo_list_item_row.dart';

import 'modal_bottom_sheet_pill.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onDidChange: (_, state) {
        if (!state.isLoading &&
            state.todoList.isNotEmpty &&
            state.todoList.every((item) => item.isChecked)) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => const Pill(text: 'All done!'),
          );
        }
      },
      builder: (context, state) {
        return Stack(children: [
          Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.todoList.length,
                itemBuilder: (context, index) => TodoListItemRow(
                  index: index,
                  item: state.todoList[index],
                ),
              ),
            ),
            AddTodoListItemRow(),
          ]),
          if (state.isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
        ]);
      },
    );
  }
}
