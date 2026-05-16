import 'package:flutter_test/flutter_test.dart';
import 'package:zim_heritage_app/main.dart';

void main() {
  testWidgets('Splash screen renders ZimHeritage title', (WidgetTester tester) async {
    await tester.pumpWidget(const ZimHeritageApp());
    expect(find.text('ZimHeritage'), findsOneWidget);
    expect(find.text('Zimbabwe Heritage Curriculum'), findsOneWidget);

    // Pump past the splash screen timer to clear pending timers
    await tester.pump(const Duration(seconds: 4));
    await tester.pump();
    await tester.pump();
  });
}
