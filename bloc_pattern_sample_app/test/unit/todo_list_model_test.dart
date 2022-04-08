import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Todo List Item', () {
    test('are equal when text and checked state are equal', () {
      const item1 = TodoListItem(text: 'test', isChecked: true);
      const item2 = TodoListItem(text: 'test', isChecked: true);

      expect(item1, equals(item2));
    });

    test('are not equal when text is different', () {
      const item1 = TodoListItem(text: 'test', isChecked: true);
      const item2 = TodoListItem(text: 'toast', isChecked: true);

      expect(item1, isNot(equals(item2)));
    });

    test('are not equal when checked state is different', () {
      const item1 = TodoListItem(text: 'test', isChecked: true);
      const item2 = TodoListItem(text: 'test', isChecked: false);

      expect(item1, isNot(equals(item2)));
    });
  });

  group('Todo List', () {
    test('are equal when items are equal', () {
      const list1 = TodoList([
        TodoListItem(text: 'test', isChecked: true),
        TodoListItem(text: 'toast', isChecked: true)
      ]);
      const list2 = TodoList([
        TodoListItem(text: 'test', isChecked: true),
        TodoListItem(text: 'toast', isChecked: true)
      ]);

      expect(list1, equals(list2));
    });

    test('are unequal when any items are unequal', () {
      const list1 = TodoList([
        TodoListItem(text: 'test', isChecked: true),
        TodoListItem(text: 'toast', isChecked: false)
      ]);
      const list2 = TodoList([
        TodoListItem(text: 'test', isChecked: true),
        TodoListItem(text: 'toast', isChecked: true)
      ]);

      expect(list1, isNot(equals(list2)));
    });
  });
}
