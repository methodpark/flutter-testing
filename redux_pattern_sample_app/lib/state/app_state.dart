import 'package:redux_pattern_sample_app/model/todo_list_item.dart';

class AppState {
  final List<TodoListItem> todoList;
  final bool isLoading;

  AppState({
    required this.todoList,
    required this.isLoading,
  });

  factory AppState.initial() {
    return AppState(todoList: [], isLoading: false);
  }

  AppState copyWith({List<TodoListItem>? todoList, bool? isLoading}) {
    return AppState(
        todoList: todoList ?? this.todoList,
        isLoading: isLoading ?? this.isLoading);
  }
}
