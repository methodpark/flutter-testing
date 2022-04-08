import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_model.dart';
import 'package:bloc_pattern_sample_app/todo_list/todo_list.dart';
import 'package:flutter/widgets.dart';

import 'todo_list_item_row.dart';

class TodoListItemsColumn extends StatelessWidget {
  final List<TodoListItem> items;
  final UnaryCallback<int> removeItem;
  final BinaryCallback<int, bool> changeCheckedState;

  const TodoListItemsColumn({
    Key? key,
    required this.items,
    required this.removeItem,
    required this.changeCheckedState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => TodoListItemRow(
        key: ValueKey('Items-Row-$index'),
        item: items[index],
        removeItemPressed: () => removeItem(index),
        changeCheckedState: (isNowChecked) => changeCheckedState(index, isNowChecked),
      ),
    );
  }
}
