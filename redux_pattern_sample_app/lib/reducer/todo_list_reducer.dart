import 'package:redux/redux.dart';
import 'package:redux_pattern_sample_app/model/todo_list_item.dart';

import '../state/app_state.dart';

final todoListReducer = combineReducers<AppState>([
  TypedReducer<AppState, AddTodoListItemAction>(_addTodoListItem),
  TypedReducer<AppState, RemoveTodoListItemAction>(_removeTodoListItem),
  TypedReducer<AppState, CheckTodoListItemAction>(_checkTodoListItem),
  TypedReducer<AppState, UncheckTodoListItemAction>(_uncheckTodoListItem),
  TypedReducer<AppState, ToggleIsLoadingAction>(_toggleIsLoading)
]);

class AddTodoListItemAction {
  final String newTodoListItem;
  AddTodoListItemAction(this.newTodoListItem);
}

class RemoveTodoListItemAction {
  final int todoListItemIndex;
  RemoveTodoListItemAction(this.todoListItemIndex);
}

class CheckTodoListItemAction {
  final int todoListItemIndex;
  CheckTodoListItemAction(this.todoListItemIndex);
}

class UncheckTodoListItemAction {
  final int todoListItemIndex;
  UncheckTodoListItemAction(this.todoListItemIndex);
}

class ToggleIsLoadingAction {
  final bool isLoading;
  ToggleIsLoadingAction(this.isLoading);
}

AppState _addTodoListItem(AppState state, AddTodoListItemAction action) {
  List<TodoListItem> newState = state.todoList;
  newState.add(TodoListItem(text: action.newTodoListItem));

  return state.copyWith(todoList: newState);
}

AppState _removeTodoListItem(AppState state, RemoveTodoListItemAction action) {
  List<TodoListItem> newState = state.todoList;
  newState.removeAt(action.todoListItemIndex);

  return state.copyWith(todoList: newState);
}

AppState _checkTodoListItem(AppState state, CheckTodoListItemAction action) {
  List<TodoListItem> newState = state.todoList;

  newState[action.todoListItemIndex].isChecked = true;

  return state.copyWith(todoList: newState);
}

AppState _uncheckTodoListItem(
    AppState state, UncheckTodoListItemAction action) {
  List<TodoListItem> newState = state.todoList;

  newState[action.todoListItemIndex].isChecked = false;

  return state.copyWith(todoList: newState);
}

AppState _toggleIsLoading(AppState state, ToggleIsLoadingAction action) {
  return state.copyWith(isLoading: action.isLoading);
}
