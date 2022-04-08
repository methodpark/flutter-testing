import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_bloc.dart';
import 'package:bloc_pattern_sample_app/todo_list/view/todo_list_items_column_view.dart';
import 'package:bloc_pattern_sample_app/todo_list/widgets/add_todo_list_item_row.dart';
import 'package:bloc_pattern_sample_app/todo_list/widgets/modal_bottom_sheet_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoListBloc>();

    return BlocConsumer<TodoListBloc, TodoListState>(
      bloc: bloc,
      builder: (context, state) {
        return Stack(children: [
          Column(children: [
            const Expanded(
              child: TodoListItemsColumnView(),
            ),
            AddTodoListItemRow(addButtonPressed: (String text) {
              bloc.add(AddTodoListItem(text));
            }),
          ]),
          if (state.isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
        ]);
      },
      listener: (context, state) {
        if (!state.isLoading &&
            state.model.items.isNotEmpty &&
            state.model.items.every((item) => item.isChecked)) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => const Pill(text: 'All done!'),
          );
        }
      },
    );
  }
}
