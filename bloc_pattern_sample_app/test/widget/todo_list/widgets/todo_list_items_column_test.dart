import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_model.dart';
import 'package:bloc_pattern_sample_app/todo_list/widgets/todo_list_item_row.dart';
import 'package:bloc_pattern_sample_app/todo_list/widgets/todo_list_items_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class BinaryFunction<T1, T2> {
  void call(T1 arg1, T2 arg2);
}

abstract class UnaryFunction<T> {
  void call(T arg);
}

class BinaryFunctionMock<T1, T2> extends Mock implements BinaryFunction<T1, T2> {}

class UnaryFunctionMock<T> extends Mock implements UnaryFunction<T> {}

void main() {
  Future<void> pumpApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }

  group('TodoListItemsColumn', () {
    const items = [
      TodoListItem(text: 'Hallo Welt'),
      TodoListItem(text: 'Hello World'),
      TodoListItem(text: 'Hola Mundo'),
    ];

    testWidgets('Displays the items', (tester) async {
      await pumpApp(
        tester,
        TodoListItemsColumn(
          items: items,
          removeItem: (index) {},
          changeCheckedState: (index, bool foo) {},
        ),
      );

      bool Function(Widget) isTodoListRowWithItem(TodoListItem item) =>
          (Widget widget) => widget is TodoListItemRow && widget.item == item;

      expect(
        find.byWidgetPredicate(isTodoListRowWithItem(items[0])),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(isTodoListRowWithItem(items[1])),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(isTodoListRowWithItem(items[2])),
        findsOneWidget,
      );
    });

    testWidgets('Calls its callback when the checkbox is tapped to check', (tester) async {
      final changeCheckedState = BinaryFunctionMock<int, bool>();

      await pumpApp(
        tester,
        TodoListItemsColumn(
          items: items,
          removeItem: (_) {},
          changeCheckedState: changeCheckedState,
        ),
      );

      await tester.tap(find.byType(Checkbox).at(1));

      verify(() => changeCheckedState(1, true)).called(1);
    });

    testWidgets('Calls its callback when the checkbox is tapped to uncheck', (tester) async {
      final changeCheckedState = BinaryFunctionMock<int, bool>();

      await pumpApp(
        tester,
        TodoListItemsColumn(
          items: [
            items[0],
            TodoListItem(text: items[1].text, isChecked: true),
            items[1],
          ],
          removeItem: (_) {},
          changeCheckedState: changeCheckedState,
        ),
      );

      await tester.tap(find.byType(Checkbox).at(1));

      verify(() => changeCheckedState(1, false)).called(1);
    });

    testWidgets('Calls its callback when the remove button is tapped', (tester) async {
      final removeItem = UnaryFunctionMock<int>();

      await pumpApp(
        tester,
        TodoListItemsColumn(
          items: items,
          removeItem: removeItem,
          changeCheckedState: (index, bool foo) {},
        ),
      );

      await tester.tap(find.text('X').at(1));

      verify(() => removeItem(1)).called(1);
    });
  });
}
