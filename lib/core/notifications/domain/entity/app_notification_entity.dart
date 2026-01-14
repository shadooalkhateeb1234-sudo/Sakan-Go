import 'package:equatable/equatable.dart';

import '../../notification_payload.dart';

class AppNotification extends Equatable {
  final String id;
  final String title;
  final String body;
  final NotificationPayload payload;
  final DateTime date;
  bool read;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.date,
    this.read = false,
  });

  AppNotification copyWith({bool? read}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
      date: date,
      read: read ?? this.read,
    );
  }

  @override
  List<Object?> get props => [id, title, body, read, date];
}
