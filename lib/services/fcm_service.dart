
import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FcmService {
  // Meminta izin dan mengambil Firebase Installation ID
  static Future<String?> requestPermissionAndGetToken() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final allowed =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    if (!allowed) {
      return null;
    }

    final installationIdFuture = messaging.onRegistered.first;

    await messaging.register();

    final installationId = await installationIdFuture.timeout(
      const Duration(seconds: 15),
    );

    return installationId;
  }

  // Mengirim Firebase Installation ID ke Laravel
  static Future<bool> registerDeviceToBackend({
    required String fid,
    required String authToken,
  }) async {
    const baseUrl = 'http://10.167.228.102:8000/api';

    final response = await http.post(
      Uri.parse('$baseUrl/device/register'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({
        'fid': fid,
      }),
    );

    print('DEBUG: Status registrasi perangkat: ${response.statusCode}');
    print('DEBUG: Respons Laravel: ${response.body}');

    return response.statusCode == 200;
  }
}
