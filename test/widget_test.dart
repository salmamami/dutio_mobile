import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dutio_mobile/main.dart';

void main() {
  testWidgets('member can complete checklist and send a chat message', (
    tester,
  ) async {
    await _openLogin(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome'), findsOneWidget);

    await tester.ensureVisible(find.text('To Do Checklist'));
    await tester.tap(find.text('To Do Checklist'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Mission Cleanliness'), findsOneWidget);
    expect(find.text('0/4'), findsOneWidget);
    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();
    expect(find.text('1/4'), findsOneWidget);

    await tester.tap(find.text('Chat'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Saya selesai piket.');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Saya selesai piket.'), findsOneWidget);

    await tester.tap(find.text('Points'));
    await tester.pumpAndSettle();
    expect(find.text('Total Poin'), findsOneWidget);
  });

  testWidgets('member can upload a report through the preview flow', (
    tester,
  ) async {
    await _openLogin(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Laporan'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Laporan'));
    await tester.pumpAndSettle();
    expect(find.text('Your Recent Files'), findsOneWidget);

    final firstGalleryImage = find
        .descendant(of: find.byType(GridView), matching: find.byType(InkWell))
        .first;
    await tester.tap(firstGalleryImage);
    await tester.pumpAndSettle();
    final uploadButton = find.widgetWithText(FilledButton, 'Unggah Foto');
    expect(tester.widget<FilledButton>(uploadButton).onPressed, isNotNull);
    await tester.tap(uploadButton);
    await tester.pumpAndSettle();
    expect(find.text('Review foto sebelum dikirim'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Upload'));
    await tester.pumpAndSettle();
    expect(find.text('Upload Complete'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Kembali ke Home'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome'), findsOneWidget);
  });

  testWidgets(
    'coordinator role opens its dashboard and can evaluate a mission',
    (tester) async {
      await _openLogin(tester);
      await tester.tap(find.text('Koordinator'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Login'));
      await tester.pumpAndSettle();
      expect(find.text('Captain!'), findsOneWidget);

      await tester.tap(find.text('Data Center'));
      await tester.pumpAndSettle();
      expect(find.text('32'), findsOneWidget);
      await tester.tap(find.text('Area Piket').last);
      await tester.pumpAndSettle();
      expect(find.text('Daftar area tugas'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Evaluasi'));
      await tester.pumpAndSettle();
      expect(find.text('Crew Performance'), findsOneWidget);
      await tester.tap(find.text('Mission'));
      await tester.pumpAndSettle();
      final firstMission = find.text('Menyapu lantai kamar mandi');
      await tester.ensureVisible(firstMission);
      await tester.tap(firstMission);
      await tester.pumpAndSettle();
      expect(find.text('Evaluasi Mission'), findsOneWidget);
      expect(find.text('Mission Cleanliness'), findsOneWidget);
    },
  );

  testWidgets('member can navigate notification, settings, and account routes', (
    tester,
  ) async {
    await _openLogin(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.notifications_none_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Notifikasi'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Password'));
    await tester.pumpAndSettle();
    expect(find.text('Password Lama'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Account'));
    await tester.pumpAndSettle();
    expect(find.text('Nama Pengguna'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan perubahan'));
    await tester.pumpAndSettle();
    expect(find.text('Perubahan disimpan di prototipe.'), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Crew, Let’s Move!'), findsOneWidget);
  });

  testWidgets('coordinator can open room management and report detail', (
    tester,
  ) async {
    await _openLogin(tester);
    await tester.tap(find.text('Koordinator'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Data Center'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kamar').last);
    await tester.pumpAndSettle();
    expect(find.text('KAMAR A'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Laporan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Laporan piket • Kamar A'));
    await tester.pumpAndSettle();
    expect(find.text('Laporan tugas piket sudah dikirim crew.'), findsOneWidget);
  });
}

Future<void> _openLogin(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(393, 852);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const DutioApp());
  await tester.pump(const Duration(milliseconds: 1300));
  await tester.pumpAndSettle();
  expect(find.text('Crew, Let’s Move!'), findsOneWidget);
}
