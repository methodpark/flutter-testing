import 'package:flutter_test/flutter_test.dart';
import 'package:redux_pattern_sample_app/model/todo_list_item.dart';

void main() {
  group('Todo List Item', () {
    test('are equal when text and checked state are equal', () {
      final item1 = TodoListItem(text: 'test', isChecked: true);
      final item2 = TodoListItem(text: 'test', isChecked: true);

      expect(item1, equals(item2));
    });

    test('are not equal when text is different', () {
      final item1 = TodoListItem(text: 'test', isChecked: true);
      final item2 = TodoListItem(text: 'toast', isChecked: true);

      expect(item1, isNot(equals(item2)));
    });

    test('are not equal when checked state is different', () {
      final item1 = TodoListItem(text: 'test', isChecked: true);
      final item2 = TodoListItem(text: 'test', isChecked: false);

      expect(item1, isNot(equals(item2)));
    });
  });

  group('Todo List', () {
    test('empty const has returns zero items', () {
      const emptyList = TodoList.empty();

      expect(emptyList.items.isEmpty, true);
    });

    test('are equal when items are equal', () {
      final list1 = TodoList([
        TodoListItem(text: 'test', isChecked: true),
        TodoListItem(text: 'toast', isChecked: true)
      ]);
      final list2 = TodoList([
        TodoListItem(text: 'test', isChecked: true),
        TodoListItem(text: 'toast', isChecked: true)
      ]);

      expect(list1, equals(list2));
    });

    test('are unequal when any items are unequal', () {
      final list1 = TodoList([
        TodoListItem(text: 'test', isChecked: true),
        TodoListItem(text: 'toast', isChecked: false)
      ]);
      final list2 = TodoList([
        TodoListItem(text: 'test', isChecked: true),
        TodoListItem(text: 'toast', isChecked: true)
      ]);

      expect(list1, isNot(equals(list2)));
    });
  });
}
