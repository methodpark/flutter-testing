import 'package:bloc_pattern_sample_app/todo_list/widgets/add_todo_list_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class UnaryStringFunction {
  void call(String foo);
}

class UnaryStringFunctionMock extends Mock implements UnaryStringFunction {}

void main() {
  Future<void> pumpApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }

  group('AddTodoListItem', () {
    testWidgets('Adds the entered text when the add button is tapped', (tester) async {
      final addItem = UnaryStringFunctionMock();

      await pumpApp(
        tester,
        AddTodoListItemRow(
          addButtonPressed: addItem,
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hallo Welt');
      await tester.tap(find.text('Add'));

      verify(() => addItem('Hallo Welt')).called(1);
    });
  });
}
