import 'package:equatable/equatable.dart';

import './todo_list_model.dart';

abstract class TodoListState with EquatableMixin {
  final TodoList model;
  final bool isLoading;

  const TodoListState(this.model, this.isLoading);

  @override
  List<Object?> get props => [model, isLoading];
}

class InitialTodoListState extends TodoListState {
  const InitialTodoListState() : super(const TodoList.empty(), false);
}

class LoadingTodoListState extends TodoListState {
  const LoadingTodoListState(TodoList model) : super(model, true);
}

class ChangedTodoListState extends TodoListState {
  const ChangedTodoListState(TodoList model) : super(model, false);
}
