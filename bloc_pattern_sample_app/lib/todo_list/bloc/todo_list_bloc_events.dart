import 'package:equatable/equatable.dart';

abstract class TodoListEvent with EquatableMixin {
  const TodoListEvent();
}

class LoadListFromBackend extends TodoListEvent {
  @override
  final List<Object?> props = [];
}

class AddTodoListItem extends TodoListEvent {
  final String content;

  const AddTodoListItem(this.content);

  @override
  List<Object?> get props => [content];
}

class RemoveTodoListItem extends TodoListEvent {
  final int index;

  const RemoveTodoListItem(this.index);

  @override
  List<Object?> get props => [index];
}

class CheckTodoListItem extends TodoListEvent {
  final int index;

  const CheckTodoListItem(this.index);

  @override
  List<Object?> get props => [index];
}

class UncheckTodoListItem extends TodoListEvent {
  final int index;

  const UncheckTodoListItem(this.index);

  @override
  List<Object?> get props => [index];
}
