import 'package:bloc_pattern_sample_app/services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './todo_list_bloc_state.dart';
import './todo_list_model.dart';

export './todo_list_bloc_state.dart';
export './todo_list_model.dart';

class TodoListCubit extends Cubit<TodoListState> {
  final HttpService httpService;

  TodoListCubit(this.httpService) : super(const InitialTodoListState());

  Future<void> loadListFromBackend() async {
    emit(LoadingTodoListState(state.model));
    final resultFromServer = await httpService.loadFromServer();
    emit(ChangedTodoListState(resultFromServer));
  }

  Future<void> addItemToTodoList(String newItemText) async {
    final newItem = TodoListItem(text: newItemText, isChecked: false);
    final newList = TodoList([...state.model.items, newItem]);

    emit(LoadingTodoListState(newList));
    final resultFromServer = await httpService.storeOnServer(newList);
    emit(ChangedTodoListState(resultFromServer));
  }

  Future<void> removeItemFromTodoList(int index) async {
    final newItems = [...state.model.items];
    newItems.removeAt(index);
    final newList = TodoList(newItems);

    emit(LoadingTodoListState(newList));
    final resultFromServer = await httpService.storeOnServer(newList);
    emit(ChangedTodoListState(resultFromServer));
  }

  Future<void> checkItemOnTodoList(int index) async {
    // TODO: what happens if we only change the item's bool?
    final newItems = [...state.model.items];
    newItems[index] = TodoListItem(text: newItems[index].text, isChecked: true);
    final newList = TodoList(newItems);

    emit(LoadingTodoListState(newList));
    final resultFromServer = await httpService.storeOnServer(newList);
    emit(ChangedTodoListState(resultFromServer));
  }

  Future<void> uncheckItemOnTodoList(int index) async {
    // TODO: what happens if we only change the item's bool?
    final newItems = [...state.model.items];
    newItems[index] =
        TodoListItem(text: newItems[index].text, isChecked: false);
    final newList = TodoList(newItems);

    emit(LoadingTodoListState(newList));
    final resultFromServer = await httpService.storeOnServer(newList);
    emit(ChangedTodoListState(resultFromServer));
  }
}
