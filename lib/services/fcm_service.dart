
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  static Future<String?> requestPermissionAndGetToken() async {
    final messaging = FirebaseMessaging.instance;

    // Meminta izin notifikasi
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Memeriksa izin pengguna
    final allowed =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    if (!allowed) {
      return null;
    }

    // Mendengarkan Firebase Installation ID sebelum registrasi
    final installationIdFuture = messaging.onRegistered.first;

    // Mendaftarkan perangkat ke Firebase
    await messaging.register();

    // Mengambil ID perangkat yang diberikan Firebase
    final installationId = await installationIdFuture.timeout(
      const Duration(seconds: 15),
    );

    return installationId;
  }
}
