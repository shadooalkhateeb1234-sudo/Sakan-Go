import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan_go/core/notifications/presentation/blocs/notification_bloc.dart';
import '../routing/app_router.dart';
import 'domain/entity/app_notification_entity.dart';
import 'repository/notification_dispatcher.dart';
import 'presentation/utils/notification_navigator.dart';
import 'notification_payload.dart';

class FirebaseNotificationService {
  FirebaseNotificationService._();
  static final instance = FirebaseNotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// 🔹 INIT
  Future<void> init() async {
    await _requestPermission();
    await _configureForeground();
    await _configureBackground();
    await _logToken();
  }

  /// 🔐 PERMISSIONS
  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// 📲 TOKEN
  Future<void> _logToken() async {
    final token = await _messaging.getToken();
    if (token == null) return;

    debugPrint('🔥 FCM TOKEN: $token');

    /// send to backend
    await _sendTokenToBackend(token);

    /// listen refresh
    FirebaseMessaging.instance.onTokenRefresh.listen(
          (newToken) async {
        await _sendTokenToBackend(newToken);
      },
    );
  }


  /// 🟢 FOREGROUND

  Future<void> _configureForeground() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 Foreground Notification');

      final payload = NotificationPayload.fromMap(message.data);

      /// 1️⃣ تحديث Blocs (Bookings / Owner)
      NotificationDispatcher.dispatch(payload);

      /// 2️⃣ تخزين الإشعار في Inbox
      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        context.read<NotificationBloc>().add(
          AddNotification(
            AppNotification(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: message.notification?.title ?? 'Sakan Go',
              body: message.notification?.body ?? '',
              payload: payload,
              date: DateTime.now(),
            ),
          ),
        );
      }
    });
  }


  /// 🔵 BACKGROUND / TERMINATED
  Future<void> _configureBackground() async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('📩 Opened from Notification');
      _handleMessage(message, fromBackground: true);
    });
  }

  /// 🧠 MESSAGE HANDLER
  /// import 'notification_payload.dart';
  /// void _handleMessage(

  void _handleMessage(
    RemoteMessage message, {
    required bool fromBackground,
  }) {
    final payload = NotificationPayload.fromMap(message.data);

    NotificationDispatcher.dispatch(payload);
    if (!fromBackground) {
      NotificationNavigator.navigate(payload);
    }
    debugPrint('🔔 Parsed Payload: ${payload.type} / ${payload.action}');

  }

  void sendToTenant({
    required int bookingId,
    required BookingAction action,
  }) {
    // TODO:
    // POST /notifications/send
    // body:
    // {
    //   booking_id: bookingId,
    //   action: action.name,
    //   target: "tenant"
    // }
  }

  Future<void> _sendTokenToBackend(String newToken) async {}


}
