
class NotificationEntity {
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final bool read;

  NotificationEntity({
    required this.title,
    required this.body,
    required this.data,
    required this.createdAt,
    this.read = false,
  });
}

// FirebaseMessaging.onMessage.listen((message) {
// final notification = NotificationEntity(
// title: message.notification?.title ?? '',
// body: message.notification?.body ?? '',
// data: message.data,
// createdAt: DateTime.now(),
// );
//
// context.read<NotificationBloc>().add(
// AddNotificationEvent(notification),
// );
// });

