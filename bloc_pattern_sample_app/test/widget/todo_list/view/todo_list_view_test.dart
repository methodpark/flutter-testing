import 'dart:async';

import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_bloc.dart';
import 'package:bloc_pattern_sample_app/todo_list/view/todo_list_view.dart';
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

  group('TodoListView', () {
    late TodoListBloc todoListBloc;

    setUp(() {
      todoListBloc = TodoListMockBloc();
    });

    testWidgets('should render no spinner initially', (tester) async {
      when(() => todoListBloc.state).thenReturn(
        const InitialTodoListState(),
      );

      await pumpApp(
        tester,
        BlocProvider.value(
          value: todoListBloc,
          child: const TodoListView(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should render a spinner while loading', (tester) async {
      when(() => todoListBloc.state).thenReturn(
        const LoadingTodoListState(TodoList.empty()),
      );

      await pumpApp(
        tester,
        BlocProvider.value(
          value: todoListBloc,
          child: const TodoListView(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should render no spinner when the data has been stored', (tester) async {
      when(() => todoListBloc.state).thenReturn(
        const ChangedTodoListState(TodoList.empty()),
      );

      await pumpApp(
        tester,
        BlocProvider.value(
          value: todoListBloc,
          child: const TodoListView(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should display a bottom sheet with a hint when all is done', (tester) async {
      final blocStream = StreamController<TodoListState>();
      whenListen(
        todoListBloc,
        blocStream.stream,
        initialState: const LoadingTodoListState(TodoList.empty()),
      );

      await pumpApp(
        tester,
        BlocProvider.value(
          value: todoListBloc,
          child: const TodoListView(),
        ),
      );

      blocStream.sink.add(const ChangedTodoListState(
        TodoList([TodoListItem(isChecked: true, text: 'test')]),
      ));
      await tester.pump();
      await expectLater(find.text('All done!'), findsOneWidget);
    });
  });
}
