import 'package:flutter_test/flutter_test.dart';
import 'package:life_garden/main.dart';

void main() {
  testWidgets('Life Garden home screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeGardenApp());
    await tester.pumpAndSettle();

    expect(find.text('Life Garden'), findsOneWidget);
    expect(find.text('Grow with intention'), findsOneWidget);
    expect(find.text('New habit'), findsOneWidget);
  });
}
