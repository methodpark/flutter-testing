import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_model.dart';
import 'package:bloc_pattern_sample_app/todo_list/widgets/todo_list_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class UnaryBoolFunction {
  void call(bool foo);
}

abstract class VoidFunction {
  void call();
}

class UnaryBoolFunctionMock extends Mock implements UnaryBoolFunction {}

class VoidFunctionMock extends Mock implements VoidFunction {}

void main() {
  Future<void> pumpApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }

  group('TodoListItemRow', () {
    testWidgets('Displays the item text', (tester) async {
      await pumpApp(
        tester,
        TodoListItemRow(
          item: const TodoListItem(text: 'Hallo Welt'),
          removeItemPressed: () {},
          changeCheckedState: (bool foo) {},
        ),
      );

      expect(find.text('Hallo Welt'), findsOneWidget);
    });

    testWidgets('Calls its callback when the checkbox is tapped to check', (tester) async {
      final changeCheckedState = UnaryBoolFunctionMock();

      await pumpApp(
        tester,
        TodoListItemRow(
          item: const TodoListItem(text: 'Hallo Welt'),
          removeItemPressed: () {},
          changeCheckedState: changeCheckedState,
        ),
      );

      await tester.tap(find.byType(Checkbox));

      verify(() => changeCheckedState(true)).called(1);
    });

    testWidgets('Calls its callback when the checkbox is tapped to uncheck', (tester) async {
      final changeCheckedState = UnaryBoolFunctionMock();

      await pumpApp(
        tester,
        TodoListItemRow(
          item: const TodoListItem(text: 'Hallo Welt', isChecked: true),
          removeItemPressed: () {},
          changeCheckedState: changeCheckedState,
        ),
      );

      await tester.tap(find.byType(Checkbox));

      verify(() => changeCheckedState(false)).called(1);
    });

    testWidgets('Calls its callback when the remove button is tapped', (tester) async {
      final removeItem = VoidFunctionMock();

      await pumpApp(
        tester,
        TodoListItemRow(
          item: const TodoListItem(text: 'Hallo Welt', isChecked: true),
          removeItemPressed: removeItem,
          changeCheckedState: (bool foo) {},
        ),
      );

      await tester.tap(find.text('X'));

      verify(() => removeItem()).called(1);
    });
  });
}
