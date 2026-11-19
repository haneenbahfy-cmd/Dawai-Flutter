import 'package:flutter_test/flutter_test.dart';
import 'package:dawai_flutter/app.dart';

void main() {
  testWidgets('Dawai app starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const DawaiApp());

    expect(find.text("Dawa'i"), findsOneWidget);
    expect(find.text("دوائي"), findsOneWidget);
  });
}