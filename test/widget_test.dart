import 'package:flutter_test/flutter_test.dart';
import 'package:ewaste_saathi/main.dart';

void main() {
  testWidgets('E-Waste Saathi Login & Navigation Smoke Test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const EWasteSaathiApp());
    await tester.pumpAndSettle();

    // Verify Login Screen displays branding and button
    expect(find.text('E-Waste Saathi'), findsOneWidget);
    expect(find.text('OTP Bhejein'), findsOneWidget);

    // Tap OTP Bhejein button
    await tester.tap(find.text('OTP Bhejein'));
    await tester.pumpAndSettle();

    // Verify OTP Screen displays
    expect(find.text('OTP Verification'), findsOneWidget);
    expect(find.text('Verify OTP'), findsOneWidget);

    // Tap Verify OTP
    await tester.tap(find.text('Verify OTP'));
    await tester.pumpAndSettle();

    // Verify Dashboard displays
    expect(find.text('Namaste, Ramesh ji 👋'), findsOneWidget);
    expect(find.text('Naya E-Waste Lot Banayein'), findsOneWidget);
  });
}
