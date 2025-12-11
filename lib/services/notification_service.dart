import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:second_laboratory_exercise/services/api_service.dart';

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> initFCM() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground Message: ${message.notification?.title}');
    });
  }
}
