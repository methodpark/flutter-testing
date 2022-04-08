import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('add items', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // add first item
      await tester.enterText(find.byType(TextField), 'first item');
      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(find.byType(Checkbox), findsOneWidget);

      // add second item
      await tester.enterText(find.byType(TextField), 'second item');
      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(find.byType(Checkbox), findsNWidgets(2));

      // add third item
      await tester.enterText(find.byType(TextField), 'third item');
      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(find.byType(Checkbox), findsNWidgets(3));

      // remove last item
      await tester.tap(find.widgetWithText(MaterialButton, 'X').last);
      await tester.pump();

      expect(find.text('first item'), findsOneWidget);
      expect(find.text('second item'), findsOneWidget);
      expect(find.text('third item'), findsNothing);

      // check first item
      final firstCheckboxFinder = find.byType(Checkbox).at(0);
      final secondCheckboxFinder = find.byType(Checkbox).at(1);

      await tester.tap(firstCheckboxFinder);
      await tester.pump();

      expect((tester.widget(firstCheckboxFinder) as Checkbox).value, true);
      expect((tester.widget(secondCheckboxFinder) as Checkbox).value, false);

      // check second item
      await tester.tap(secondCheckboxFinder);
      await tester.pumpAndSettle();

      expect((tester.widget(firstCheckboxFinder) as Checkbox).value, true);
      expect((tester.widget(secondCheckboxFinder) as Checkbox).value, true);
      expect(find.text('All done!'), findsOneWidget);
    });
  });
}
