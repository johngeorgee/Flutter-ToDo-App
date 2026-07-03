import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/app.dart';

void main() {
  testWidgets('App loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TodoApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Tasks'), findsOneWidget);
  });
}
