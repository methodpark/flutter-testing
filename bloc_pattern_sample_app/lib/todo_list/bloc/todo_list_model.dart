import 'package:equatable/equatable.dart';

class TodoListItem with EquatableMixin {
  final String text;
  final bool isChecked;

  const TodoListItem({this.isChecked = false, required this.text});

  @override
  List<Object?> get props => [text, isChecked];
}

class TodoList with EquatableMixin {
  final List<TodoListItem> items;

  const TodoList(this.items);
  const TodoList.empty() : items = const [];

  @override
  List<Object?> get props => [items];
}
