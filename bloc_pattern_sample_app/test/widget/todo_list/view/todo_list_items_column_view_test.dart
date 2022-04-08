import 'dart:async';

import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_bloc.dart';
import 'package:bloc_pattern_sample_app/todo_list/view/todo_list_items_column_view.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class TodoListMockBloc extends MockBloc<TodoListEvent, TodoListState> implements TodoListBloc {}

void main() {
  Future<void> pumpApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }

  group('TodoListItemsColumnView', () {
    late TodoListBloc todoListBloc;

    setUp(() {
      todoListBloc = TodoListMockBloc();
    });

    testWidgets('should add a RemoveItemEvent when the remove button is pressed', (tester) async {
      when(() => todoListBloc.state).thenReturn(
        const ChangedTodoListState(
          TodoList([TodoListItem(text: 'First')]),
        ),
      );

      await pumpApp(
        tester,
        BlocProvider.value(
          value: todoListBloc,
          child: const TodoListItemsColumnView(),
        ),
      );

      await tester.tap(find.text('X'));

      verify(() => todoListBloc.add(const RemoveTodoListItem(0))).called(1);
    });

    testWidgets('should add an UncheckItemEvent when the uncheck button is pressed',
        (tester) async {
      when(() => todoListBloc.state).thenReturn(
        const ChangedTodoListState(
          TodoList([TodoListItem(text: 'First', isChecked: true)]),
        ),
      );

      await pumpApp(
        tester,
        BlocProvider.value(
          value: todoListBloc,
          child: const TodoListItemsColumnView(),
        ),
      );

      await tester.tap(find.byType(Checkbox).first);

      verify(() => todoListBloc.add(const UncheckTodoListItem(0))).called(1);
    });

    testWidgets('should add an CheckItemEvent when the check button is pressed', (tester) async {
      when(() => todoListBloc.state).thenReturn(
        const ChangedTodoListState(
          TodoList([TodoListItem(text: 'First', isChecked: false)]),
        ),
      );

      await pumpApp(
        tester,
        BlocProvider.value(
          value: todoListBloc,
          child: const TodoListItemsColumnView(),
        ),
      );

      await tester.tap(find.byType(Checkbox).first);

      verify(() => todoListBloc.add(const CheckTodoListItem(0))).called(1);
    });
  });
}
