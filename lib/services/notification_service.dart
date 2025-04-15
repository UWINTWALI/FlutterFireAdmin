import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static const String _serverKey =
      'YOUR_FIREBASE_SERVER_KEY'; // Replace with your actual FCM server key

  static Future<void> sendPushNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$_serverKey',
        },
        body: jsonEncode({
          'to': token,
          'notification': {'title': title, 'body': body},
          'priority': 'high',
        }),
      );
    } catch (e) {
      print('Push notification error: $e');
    }
  }
}
