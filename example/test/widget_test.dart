import 'package:flutter_test/flutter_test.dart';

import 'package:dacs_example/main.dart';

void main() {
  testWidgets('App renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const DacsExampleApp());
    expect(find.text('DACS Example'), findsOneWidget);
    expect(find.text('Text Styles'), findsOneWidget);
  });
}
