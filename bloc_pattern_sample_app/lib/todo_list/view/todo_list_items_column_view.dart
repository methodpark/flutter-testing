import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_bloc.dart';
import 'package:bloc_pattern_sample_app/todo_list/widgets/todo_list_items_column.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListItemsColumnView extends StatelessWidget {
  const TodoListItemsColumnView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoListBloc>();
    return BlocBuilder<TodoListBloc, TodoListState>(
      bloc: bloc,
      builder: (context, state) {
        return TodoListItemsColumn(
          items: state.model.items,
          removeItem: (index) => bloc.add(RemoveTodoListItem(index)),
          changeCheckedState: (index, isNowChecked) {
            if (isNowChecked) {
              bloc.add(CheckTodoListItem(index));
            } else {
              bloc.add(UncheckTodoListItem(index));
            }
          },
        );
      },
    );
  }
}
