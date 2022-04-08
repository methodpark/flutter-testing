import 'package:flutter_test/flutter_test.dart';
import 'package:redux_pattern_sample_app/model/todo_list_item.dart';
import 'package:redux_pattern_sample_app/reducer/todo_list_reducer.dart';
import 'package:redux_pattern_sample_app/state/app_state.dart';

void main() {
  group('addTodoListItemAction', () {
    group('When item is added', () {
      AppState inputState = AppState(todoList: [], isLoading: false);

      var addItemAction = AddTodoListItemAction('first item');
      test('Then todo list has one unchecked item', () {
        AppState outputState = todoListReducer(inputState, addItemAction);

        expect(outputState.todoList.length, 1);
        expect(outputState.todoList.first.isChecked, false);
        expect(outputState.todoList.first.text, 'first item');
      });
    });
  });

  group('RemoveTodoListItem', () {
    AppState inputState = AppState(todoList: [
      TodoListItem(isChecked: true, text: 'checked item'),
      TodoListItem(isChecked: false, text: 'unchecked item'),
    ], isLoading: false);

    group('When last item is removed', () {
      var removeItemAction = RemoveTodoListItemAction(1);

      test('Then only first item is left', () {
        AppState outputState = todoListReducer(inputState, removeItemAction);

        expect(outputState.todoList.length, 1);
        expect(outputState.todoList.first.isChecked, true);
        expect(outputState.todoList.first.text, 'checked item');
      });
    });
  });

  group('CheckTodoListItem', () {
    AppState inputState = AppState(todoList: [
      TodoListItem(isChecked: false, text: 'checked item'),
    ], isLoading: false);

    group('When checking todo list item', () {
      var checkItemAction = CheckTodoListItemAction(0);

      test('Then todo list item is checked', () {
        AppState outputState = todoListReducer(inputState, checkItemAction);

        expect(outputState.todoList.first.isChecked, true);
      });
    });
  });

  group('UncheckTodoListItem', () {
    AppState inputState = AppState(todoList: [
      TodoListItem(isChecked: true, text: 'checked item'),
    ], isLoading: false);

    group('When unchecking todo list item', () {
      var uncheckItemAction = UncheckTodoListItemAction(0);

      test('Then todo list item is unchecked', () {
        AppState outputState = todoListReducer(inputState, uncheckItemAction);

        expect(outputState.todoList.first.isChecked, false);
      });
    });
  });

  group('ToggleIsLoadingAction', () {
    group('When isLoading is false', () {
      AppState inputState = AppState(todoList: [], isLoading: false);

      test('Then isLoading is toggled to true', () {
        var toggleIsLoadingAction = ToggleIsLoadingAction(true);

        AppState outputState =
            todoListReducer(inputState, toggleIsLoadingAction);

        expect(outputState.isLoading, true);
      });
    });
  });
}
