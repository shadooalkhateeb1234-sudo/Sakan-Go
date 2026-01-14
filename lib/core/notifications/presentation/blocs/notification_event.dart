part of 'notification_bloc.dart';


abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class AddNotification extends NotificationEvent {
  final AppNotification notification;

  const AddNotification(this.notification);

  @override
  List<Object?> get props => [notification];
}

class MarkAsRead extends NotificationEvent {
  final String id;

  const MarkAsRead(this.id);

  @override
  List<Object?> get props => [id];
}

class ClearNotifications extends NotificationEvent {}

