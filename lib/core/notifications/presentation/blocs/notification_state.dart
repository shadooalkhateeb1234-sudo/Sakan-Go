part of 'notification_bloc.dart';


abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<AppNotification> items;

  const NotificationLoaded(this.items);

  int get unreadCount =>
      items.where((n) => !n.read).length;

  @override
  List<Object?> get props => [items];
}

