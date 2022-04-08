import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_pattern_sample_app/todo_list/view/modal_bottom_sheet_pill.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }

  group('Pill', () {
    testWidgets('Should display expected text and green background',
        (tester) async {
      await pumpApp(
        tester,
        const Pill(text: 'loading'),
      );

      expect(find.text('loading'), findsOneWidget);
      final container = tester.firstWidget(find.byType(Container)) as Container;
      expect(((container.decoration) as BoxDecoration).color, Colors.green);
    });
  });
}
