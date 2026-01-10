import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirebaseNotificationService {
  FirebaseNotificationService._();
  static final instance = FirebaseNotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// init must be called after login
  Future<void> init(BuildContext context) async {
    await _requestPermission();
    await _getAndSyncToken();
    _listenForeground(context);
    _listenOpenedApp(context);
  }

  /// 🔐 Permissions (iOS + Android 13)
  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// 📱 Get FCM token & send to backend
  Future<void> _getAndSyncToken() async {
    final token = await _messaging.getToken();
    if (token != null) {
      debugPrint('🔥 FCM Token: $token');

      /// TODO:
      /// Send token to backend
      /// POST /api/store-fcm-token
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      /// TODO: update backend token
    });
  }

  /// 🔔 App in FOREGROUND
  void _listenForeground(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('🔔 Foreground notification');

      final data = message.data;
      _handleInAppNotification(context, data);
    });
  }

  /// 🚀 App opened from notification
  void _listenOpenedApp(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('🚀 Notification clicked');
      _handleNavigation(context, message.data);
    });
  }

  /// 🧠 Handle in-app notification (SnackBar / Dialog)
  void _handleInAppNotification(
      BuildContext context,
      Map<String, dynamic> data,
      ) {
    final title = data['title'] ?? 'Notification';
    final body = data['body'] ?? '';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title\n$body'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () => _handleNavigation(context, data),
        ),
      ),
    );
  }

  /// 🧭 Navigation handler (GoRouter)
  void _handleNavigation(
      BuildContext context,
      Map<String, dynamic> data,
      ) {
    final type = data['type'];

    switch (type) {
      case 'NEW_BOOKING':
        context.go('/owner/bookings');
        break;

      case 'BOOKING_APPROVED':
      case 'BOOKING_REJECTED':
        context.go('/my-bookings');
        break;

      case 'UPDATE_REQUEST':
        context.go('/owner/bookings');
        break;

      case 'UPDATE_APPROVED':
      case 'UPDATE_REJECTED':
        context.go('/my-bookings');
        break;

      default:
        debugPrint('⚠️ Unknown notification type');
    }
  }
}

// typedef NotificationTapCallback = void Function(Map<String, dynamic> data);
//
// class FirebaseNotificationService {
//   FirebaseNotificationService._();
//   static final instance = FirebaseNotificationService._();
//
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//
//   NotificationTapCallback? onNotificationTap;
//
//   /// 🔹 Init (call after login)
//   Future<void> init() async {
//     await _requestPermission();
//     await _logToken();
//     _listenForeground();
//     _listenOpenedApp();
//   }
//
//   /// 🔹 Permissions
//   Future<void> _requestPermission() async {
//     final settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     log('🔔 Notification permission: ${settings.authorizationStatus}');
//   }
//
//   /// 🔹 Token
//   Future<String?> getToken() async {
//     return await _messaging.getToken();
//   }
//
//   Future<void> _logToken() async {
//     final token = await getToken();
//     log('🔥 FCM TOKEN: $token');
//   }
//
//   /// 🔹 Foreground
//   void _listenForeground() {
//     FirebaseMessaging.onMessage.listen((message) {
//       log('📩 Foreground message: ${message.data}');
//     });
//   }
//
//   /// 🔹 When notification clicked
//   void _listenOpenedApp() {
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       if (onNotificationTap != null) {
//         onNotificationTap!(message.data);
//       }
//     });
//   }
// }
//
// /// 🔹 Background handler (top-level)
// Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   log('📦 Background message: ${message.data}');
// }
