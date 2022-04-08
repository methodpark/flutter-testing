// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import 'package:redux_pattern_sample_app/model/todo_list_item.dart' as model;
import 'package:redux_pattern_sample_app/reducer/todo_list_reducer.dart';
import 'package:redux_pattern_sample_app/state/app_state.dart';
import 'package:redux_pattern_sample_app/todo_list/view/todo_list.dart';

class TestWidget extends StatelessWidget {
  final Store<AppState> store;
  final Widget child;

  const TestWidget({required this.child, required this.store, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StoreProvider<AppState>(
          store: store,
          child: child,
        ),
      ),
    );
  }
}

void main() {
  final checkboxFinder = find.byType(Checkbox);
  group('Given todo list has zero items', () {
    final store =
        Store<AppState>(todoListReducer, initialState: AppState.initial());

    testWidgets('Then no todo list item should be found',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(child: const TodoList(), store: store),
      );

      expect(checkboxFinder, findsNothing);
      expect(find.text('X'), findsNothing);
    });
    testWidgets('Then add button should be found', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(child: const TodoList(), store: store),
      );

      expect(find.byType(MaterialButton), findsOneWidget);
    });

    group('When clicking AddButton', () {
      testWidgets('Then one new item should be displayed',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          TestWidget(child: const TodoList(), store: store),
        );

        await tester.tap(find.byKey(const Key('add_button')));
        await tester.pump();

        expect(checkboxFinder, findsOneWidget);
        expect(find.text('X'), findsOneWidget);
      });
    });
  });

  group('Given todo list has one unchecked item', () {
    late Store<AppState> store;
    setUp(() {
      AppState state = AppState(
        todoList: [model.TodoListItem(isChecked: false, text: "first item")],
        isLoading: false,
      );
      store = Store<AppState>(todoListReducer, initialState: state);
    });

    testWidgets('Then item widgets should be found',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          child: const TodoList(),
          store: store,
        ),
      );

      expect(checkboxFinder, findsOneWidget);
      expect(find.text('X'), findsOneWidget);
      expect(find.text('first item'), findsOneWidget);
    });

    testWidgets('Then checkbox is unchecked', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          child: const TodoList(),
          store: store,
        ),
      );

      expect(find.text('first item'), findsOneWidget);
      var checkbox = tester.firstWidget(checkboxFinder) as Checkbox;
      expect(checkbox.value, equals(false));
    });

    group('When clicking delete item', () {
      testWidgets('Then no todo list item should be found',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          TestWidget(child: const TodoList(), store: store),
        );

        await tester.tap(find.byKey(const Key('remove_button_0')));
        await tester.pump();

        expect(checkboxFinder, findsNothing);
        expect(find.text('X'), findsNothing);
      });
    });

    group('When checking item', () {
      testWidgets('Then item should be checked', (WidgetTester tester) async {
        await tester.pumpWidget(TestWidget(
          child: const TodoList(),
          store: store,
        ));

        await tester.tap(find.byType(Checkbox));
        await tester.pump();

        var checkbox = tester.firstWidget(checkboxFinder) as Checkbox;
        expect(checkbox.value, equals(true));
      });
    });
  });

  group('Given todo list has one checked item', () {
    late Store<AppState> store;
    setUp(() {
      AppState state = AppState(
        todoList: [model.TodoListItem(isChecked: true, text: "first item")],
        isLoading: false,
      );
      store = Store<AppState>(todoListReducer, initialState: state);
    });

    group('When unchecking item', () {
      testWidgets('Then item should not be checked',
          (WidgetTester tester) async {
        await tester.pumpWidget(TestWidget(
          child: const TodoList(),
          store: store,
        ));

        await tester.tap(find.byType(Checkbox));
        await tester.pump();

        var checkbox = tester.firstWidget(checkboxFinder) as Checkbox;
        expect(checkbox.value, equals(false));
      });
    });
  });

  group('Given isLoading is true', () {
    late Store<AppState> store;
    setUp(() {
      AppState state = AppState(
        todoList: [],
        isLoading: true,
      );
      store = Store<AppState>(todoListReducer, initialState: state);
    });

    testWidgets('Then ProgressIndicator should be visible',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestWidget(
        child: const TodoList(),
        store: store,
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Given isLoading is false', () {
    late Store<AppState> store;
    setUp(() {
      AppState state = AppState(
        todoList: [],
        isLoading: false,
      );
      store = Store<AppState>(todoListReducer, initialState: state);
    });

    testWidgets('Then ProgressIndicator should not be visible',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestWidget(
        child: const TodoList(),
        store: store,
      ));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
