import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/widgets/cancel_appointment_dialog.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

void main() {
  setUpAll(() {
    LocaleSettings.setLocale(AppLocale.en);
  });

  testWidgets('showCancelAppointmentDialog displays title, message, and handles No and Yes actions',
      (tester) async {
    bool confirmed = false;

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showCancelAppointmentDialog(
                    context: context,
                    onConfirm: () {
                      confirmed = true;
                    },
                  );
                },
                child: const Text('Open Dialog'),
              ),
            ),
          ),
        ),
      ),
    );

    // Tap button to open dialog
    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();

    // Verify dialog content
    expect(find.text(t.cancelAppointment), findsOneWidget);
    expect(find.text(t.areYouSureCancelAppointment), findsOneWidget);
    expect(find.text(t.no), findsOneWidget);
    expect(find.text(t.yesCancel), findsOneWidget);

    // Tap "No" -> dismisses dialog without confirming
    await tester.tap(find.text(t.no));
    await tester.pumpAndSettle();

    expect(find.text(t.areYouSureCancelAppointment), findsNothing);
    expect(confirmed, isFalse);

    // Re-open dialog
    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();

    // Tap "Yes, Cancel" -> dismisses dialog and invokes onConfirm
    await tester.tap(find.text(t.yesCancel));
    await tester.pumpAndSettle();

    expect(find.text(t.areYouSureCancelAppointment), findsNothing);
    expect(confirmed, isTrue);
  });
}
