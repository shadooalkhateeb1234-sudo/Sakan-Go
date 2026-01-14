import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entity/app_notification_entity.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc
    extends Bloc<NotificationEvent, NotificationState> {
  final List<AppNotification> _items = [];

  NotificationBloc() : super(NotificationInitial()) {
    on<AddNotification>(_onAdd);
    on<MarkAsRead>(_onRead);
    on<ClearNotifications>(_onClear);
  }

  void _onAdd(
      AddNotification event,
      Emitter<NotificationState> emit,
      ) {
    _items.insert(0, event.notification);
    emit(NotificationLoaded(List.from(_items)));
  }

  void _onRead(
      MarkAsRead event,
      Emitter<NotificationState> emit,
      ) {
    final index = _items.indexWhere((n) => n.id == event.id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(read: true);
    }
    emit(NotificationLoaded(List.from(_items)));
  }

  void _onClear(
      ClearNotifications event,
      Emitter<NotificationState> emit,
      ) {
    _items.clear();
    emit(const NotificationLoaded([]));
  }
}

