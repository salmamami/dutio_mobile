import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dutio_mobile/core/app_theme.dart';
import 'package:dutio_mobile/core/app_theme_controller.dart';
import 'package:dutio_mobile/main.dart';
import 'package:dutio_mobile/widgets/dutio_widgets.dart';

void main() {
  testWidgets('dark mode toggles globally and persists the preference', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await AppThemeController.instance.load();
    addTearDown(() async {
      await AppThemeController.instance.setDarkMode(false);
    });

    await _openLogin(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    final darkModeSwitch = find.widgetWithText(SwitchListTile, 'Dark Mode');
    await tester.ensureVisible(darkModeSwitch);
    await tester.tap(darkModeSwitch);
    await tester.pumpAndSettle();

    expect(AppThemeController.instance.isDarkMode, isTrue);
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.dark,
    );
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool('dutio_dark_mode'), isTrue);

    await tester.tap(find.text('Home').last);
    await tester.pumpAndSettle();
    expect(
      DutioPalette.of(tester.element(find.byType(Scaffold).first)).background,
      DutioPalette.dark.background,
    );

    await AppThemeController.instance.load();
    expect(AppThemeController.instance.isDarkMode, isTrue);
  });

  testWidgets('coordinator settings use the shared dark mode toggle', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await AppThemeController.instance.load();
    addTearDown(() async {
      await AppThemeController.instance.setDarkMode(false);
    });

    await _openLogin(tester);
    await tester.tap(find.text('Koordinator'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pengaturan'));
    await tester.pumpAndSettle();

    final darkModeSwitch = find.widgetWithText(SwitchListTile, 'Dark Mode');
    await tester.tap(darkModeSwitch);
    await tester.pumpAndSettle();

    expect(AppThemeController.instance.isDarkMode, isTrue);
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.dark,
    );
  });

  testWidgets('wide viewport displays the app in a phone-sized layout', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1024, 900);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DutioApp());
    await tester.pump();

    final appSize = tester.getSize(find.byType(Scaffold).first);
    expect(appSize.width, 430);
    expect(appSize.height, 900);
  });

  testWidgets('login fields and button use high-contrast palette colors', (
    tester,
  ) async {
    await _openLogin(tester);

    final palette = DutioPalette.of(
      tester.element(find.byType(TextField).first),
    );
    for (final field in tester.widgetList<TextField>(find.byType(TextField))) {
      expect(field.style?.color, palette.textPrimary);
      expect(field.decoration?.fillColor, palette.surface);
      expect(
        field.decoration?.hintStyle?.color,
        palette.textPrimary.withValues(alpha: .7),
      );
    }

    final loginButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Login'),
    );
    expect(
      loginButton.style?.backgroundColor?.resolve(const {}),
      palette.action,
    );
    expect(
      loginButton.style?.foregroundColor?.resolve(const {}),
      palette.onAccent,
    );
  });

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
    expect(find.text('Mission Cleanliness'), findsOneWidget);
    expect(find.byIcon(Icons.person_rounded), findsNothing);
    expect(
      find.text('Centang tugas yang sudah selesai untuk memperbarui progres.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Completed Task'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada tugas yang selesai.'), findsOneWidget);
    await tester.tap(find.text('Task List'));
    await tester.pumpAndSettle();

    final taskPanel = tester.widget<Container>(
      find.byKey(const ValueKey('mission-task-panel')),
    );
    expect(
      (taskPanel.decoration! as BoxDecoration).color,
      DutioPalette.of(
        tester.element(find.byKey(const ValueKey('mission-task-panel'))),
      ).background,
    );

    expect(find.text('0/4'), findsOneWidget);
    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();
    expect(find.text('1/4'), findsOneWidget);
    final completedTask = find.text('Menyapu lantai kamar mandi');
    expect(
      tester.widget<Text>(completedTask).style?.decoration,
      TextDecoration.lineThrough,
    );
    await tester.tap(find.text('Completed Task'));
    await tester.pumpAndSettle();
    expect(completedTask, findsOneWidget);
    expect(find.text('Belum ada tugas yang selesai.'), findsNothing);

    await tester.tap(find.text('Chat'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Saya selesai piket.');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Saya selesai piket.'), findsOneWidget);

    await tester.tap(find.text('Points'));
    await tester.pumpAndSettle();
    expect(find.text('Crew Points'), findsOneWidget);
    expect(find.text('Total Poin'), findsOneWidget);
    await tester.tap(find.byTooltip('Informasi poin'));
    await tester.pumpAndSettle();
    expect(
      find.text('Aktivitas piket yang valid akan tercatat sebagai poin.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Mengerti'));
    await tester.pumpAndSettle();
    expect(find.text('Kebersihan dinilai baik'), findsOneWidget);
    expect(find.text('+8'), findsOneWidget);
    expect(find.text('Piket terakhir • Kamar mandi kompleks'), findsNothing);
    await tester.tap(find.text('Evaluasi Piket'));
    await tester.pumpAndSettle();
    expect(find.text('Piket terakhir • Kamar mandi kompleks'), findsOneWidget);
    expect(find.text('Dinilai baik oleh koordinator'), findsOneWidget);
    expect(find.text('Kebersihan dinilai baik'), findsNothing);
    expect(
      find.text(
        'Evaluasi piket berikutnya akan muncul setelah penilaian selanjutnya.',
      ),
      findsOneWidget,
    );
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
    expect(find.text('Foto Terbaru Anda'), findsOneWidget);
    final dropzone = find.byKey(const ValueKey('report-upload-dropzone'));
    final instruction = find.text('Silakan pilih gambar dari galeri Anda');
    final dropzoneRect = tester.getRect(dropzone);
    final instructionRect = tester.getRect(instruction);
    expect(dropzoneRect.height, 120);
    expect(dropzoneRect.inflate(1).contains(instructionRect.topLeft), isTrue);
    expect(
      dropzoneRect.inflate(1).contains(instructionRect.bottomRight),
      isTrue,
    );

    final firstGalleryImage = find.byKey(const ValueKey('recent-photo-0'));
    expect(
      find.byKey(const ValueKey('selected-photo-indicator')),
      findsNothing,
    );
    await tester.tap(firstGalleryImage);
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('selected-photo-indicator')),
      findsOneWidget,
    );
    final selectedTile = tester.widget<Container>(
      find.byKey(const ValueKey('photo-tile-0')),
    );
    final selectedBorder = (selectedTile.decoration! as BoxDecoration).border!;
    expect(selectedBorder.top.width, 4);
    expect(
      selectedBorder.top.color,
      DutioPalette.of(tester.element(firstGalleryImage)).action,
    );
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

      final evaluationPalette = DutioPalette.of(
        tester.element(find.text('Crew Performance')),
      );
      final backButton = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.arrow_back_ios_new_rounded),
      );
      expect(backButton.color, evaluationPalette.accent);
      expect(
        tester.widget<Icon>(find.byIcon(Icons.notifications_none_rounded)).size,
        24,
      );
      expect(tester.widget<DutioLogo>(find.byType(DutioLogo)).size, 28);

      final progressRings = tester
          .widgetList<CircularProgressIndicator>(
            find.byType(CircularProgressIndicator),
          )
          .toList();
      expect(progressRings, hasLength(2));
      expect(progressRings[0].value, closeTo(7 / 20, .001));
      expect(progressRings[1].value, closeTo(20 / 70, .001));
      expect(
        tester.widget<Text>(find.text('Laporan Masuk')).style?.color,
        evaluationPalette.textPrimary,
      );
      expect(
        tester.widget<Text>(find.text('Mission Selesai')).style?.color,
        evaluationPalette.textPrimary,
      );

      final reportFilter = tester.widget<Container>(
        find.byKey(const ValueKey('evaluation-category-Laporan')),
      );
      expect(
        (reportFilter.decoration! as BoxDecoration).color,
        evaluationPalette.action,
      );
      final pendingTab = tester.widget<Container>(
        find.byKey(const ValueKey('evaluation-tab-0')),
      );
      expect(
        (pendingTab.decoration! as BoxDecoration).color,
        evaluationPalette.action,
      );
      expect(
        tester.widget<Text>(find.text('Kamar A')).style?.color,
        AppTheme.ink,
      );
      expect(find.byIcon(Icons.chevron_right_rounded), findsAtLeastNWidgets(2));
      expect(
        (tester
                    .widget<Container>(
                      find.byKey(const ValueKey('evaluation-list')),
                    )
                    .decoration!
                as BoxDecoration)
            .color,
        evaluationPalette.surfaceVariant,
      );

      await tester.tap(find.text('Mission'));
      await tester.pumpAndSettle();
      final missionFilter = tester.widget<Container>(
        find.byKey(const ValueKey('evaluation-category-Mission')),
      );
      expect(
        (missionFilter.decoration! as BoxDecoration).color,
        evaluationPalette.action,
      );
      final firstMission = find.text('Menyapu lantai kamar mandi');
      await tester.ensureVisible(firstMission);
      await tester.tap(firstMission);
      await tester.pumpAndSettle();
      expect(find.text('Evaluasi Mission'), findsOneWidget);
      expect(find.text('Mission Cleanliness'), findsOneWidget);
    },
  );

  testWidgets(
    'member can navigate notification, settings, and account routes',
    (tester) async {
      await _openLogin(tester);
      await tester.tap(find.widgetWithText(FilledButton, 'Login'));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('unread-notification-badge')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('crew-duty-image')), findsOneWidget);
      await tester.tap(find.byIcon(Icons.notifications_none_rounded));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('unread-notification-badge')),
        findsNothing,
      );
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
    },
  );

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
    expect(
      find.text('Laporan tugas piket sudah dikirim crew.'),
      findsOneWidget,
    );
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
