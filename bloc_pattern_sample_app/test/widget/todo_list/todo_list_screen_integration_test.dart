import 'package:bloc_pattern_sample_app/services/http_service.dart';
import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_model.dart';
import 'package:bloc_pattern_sample_app/todo_list/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class HttpServiceMock extends Mock implements HttpService {}

void main() {
  Future<void> pumpApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }

  group('TodoListScreen', () {
    late HttpService httpService;

    setUpAll(() {
      registerFallbackValue(const TodoList.empty());
    });

    setUp(() {
      httpService = HttpServiceMock();

      when(() => httpService.loadFromServer()).thenAnswer(
        (invocation) async => const TodoList([
          TodoListItem(text: 'First'),
          TodoListItem(text: 'Second', isChecked: true),
          TodoListItem(text: 'Third'),
        ]),
      );

      when(() => httpService.storeOnServer(any()))
          .thenAnswer((invocation) async => invocation.positionalArguments.first);
    });

    testWidgets('Should upload data to backend and display result', (tester) async {
      await pumpApp(
        tester,
        Provider.value(
          value: httpService,
          child: const TodoListScreen(),
        ),
      );

      // Initial loading
      verify(() => httpService.loadFromServer()).called(1);
      await tester.pump();

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);

      List<Checkbox> allCheckboxes;
      allCheckboxes = tester.widgetList(find.byType(Checkbox)).cast<Checkbox>().toList();
      expect(allCheckboxes[0].value, isFalse);
      expect(allCheckboxes[1].value, isTrue);
      expect(allCheckboxes[2].value, isFalse);

      // Unchecking an item
      await tester.tap(find.byType(Checkbox).at(1));
      verify(
        () => httpService.storeOnServer(const TodoList([
          TodoListItem(text: 'First', isChecked: false),
          TodoListItem(text: 'Second', isChecked: false),
          TodoListItem(text: 'Third', isChecked: false),
        ])),
      ).called(1);
      await tester.pump();

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);

      allCheckboxes = tester.widgetList(find.byType(Checkbox)).cast<Checkbox>().toList();
      expect(allCheckboxes[0].value, isFalse);
      expect(allCheckboxes[1].value, isFalse);
      expect(allCheckboxes[2].value, isFalse);

      // Removing an item
      await tester.tap(find.text('X').at(2));
      verify(
        () => httpService.storeOnServer(const TodoList([
          TodoListItem(text: 'First', isChecked: false),
          TodoListItem(text: 'Second', isChecked: false),
        ])),
      ).called(1);
      await tester.pump();

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsNothing);

      allCheckboxes = tester.widgetList(find.byType(Checkbox)).cast<Checkbox>().toList();
      expect(allCheckboxes[0].value, isFalse);
      expect(allCheckboxes[1].value, isFalse);

      // Checking all items
      await tester.tap(find.byType(Checkbox).at(0));
      await tester.tap(find.byType(Checkbox).at(1));
      await tester.pump();

      allCheckboxes = tester.widgetList(find.byType(Checkbox)).cast<Checkbox>().toList();
      expect(allCheckboxes[0].value, isTrue);
      expect(allCheckboxes[1].value, isTrue);
      expect(find.text('All done!'), findsOneWidget);

      // Remove overlay
      await tester.tapAt(const Offset(10, 10));
      await tester.pump();
      expect(find.text('All done!'), findsNothing);

      // Adding an item
      await tester.enterText(find.byType(TextField), 'New Third');
      await tester.tap(find.text('Add'));
      await tester.pump();

      allCheckboxes = tester.widgetList(find.byType(Checkbox)).cast<Checkbox>().toList();
      expect(allCheckboxes.length, 3);
      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('New Third'), findsOneWidget);
    });
  });
}
