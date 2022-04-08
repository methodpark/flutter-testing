import 'package:bloc_pattern_sample_app/services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './todo_list_bloc_events.dart';
import './todo_list_bloc_state.dart';
import './todo_list_model.dart';

export './todo_list_bloc_events.dart';
export './todo_list_bloc_state.dart';
export './todo_list_model.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final HttpService httpService;

  TodoListBloc(this.httpService) : super(const InitialTodoListState()) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<LoadListFromBackend>(_loadListFromBackend);
    on<AddTodoListItem>(_addItemToTodoList);
    on<RemoveTodoListItem>(_removeItemFromTodoList);
    on<CheckTodoListItem>(_checkItemOnTodoList);
    on<UncheckTodoListItem>(_uncheckItemOnTodoList);
  }

  void _loadListFromBackend(LoadListFromBackend event, Emitter<TodoListState> emit) async {
    emit(LoadingTodoListState(state.model));
    final resultFromServer = await httpService.loadFromServer();
    emit(ChangedTodoListState(resultFromServer));
  }

  void _addItemToTodoList(AddTodoListItem event, Emitter<TodoListState> emit) async {
    final newItem = TodoListItem(text: event.content, isChecked: false);
    final newList = TodoList([...state.model.items, newItem]);

    emit(LoadingTodoListState(newList));
    final resultFromServer = await httpService.storeOnServer(newList);
    emit(ChangedTodoListState(resultFromServer));
  }

  Future<void> _removeItemFromTodoList(
    RemoveTodoListItem event,
    Emitter<TodoListState> emit,
  ) async {
    final newItems = [...state.model.items];
    newItems.removeAt(event.index);
    final newList = TodoList(newItems);

    emit(LoadingTodoListState(newList));
    final resultFromServer = await httpService.storeOnServer(newList);
    emit(ChangedTodoListState(resultFromServer));
  }

  Future<void> _checkItemOnTodoList(
    CheckTodoListItem event,
    Emitter<TodoListState> emit,
  ) async {
    final newItems = [...state.model.items];
    newItems[event.index] = TodoListItem(text: newItems[event.index].text, isChecked: true);
    final newList = TodoList(newItems);

    emit(LoadingTodoListState(newList));
    final resultFromServer = await httpService.storeOnServer(newList);
    emit(ChangedTodoListState(resultFromServer));
  }

  Future<void> _uncheckItemOnTodoList(
    UncheckTodoListItem event,
    Emitter<TodoListState> emit,
  ) async {
    // TODO: what happens if we only change the item's bool?
    final newItems = [...state.model.items];
    newItems[event.index] = TodoListItem(text: newItems[event.index].text, isChecked: false);
    final newList = TodoList(newItems);

    emit(LoadingTodoListState(newList));
    final resultFromServer = await httpService.storeOnServer(newList);
    emit(ChangedTodoListState(resultFromServer));
  }
}
