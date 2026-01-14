import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/notification_bloc.dart';
import '../utils/notification_navigator.dart';

class NotificationInboxPage extends StatelessWidget {
  const NotificationInboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded && state.items.isNotEmpty) {
            return ListView.separated(
              itemCount: state.items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, index) {
                final n = state.items[index];

                return ListTile(
                  title: Text(
                    n.title,
                    style: TextStyle(
                      fontWeight:
                      n.read ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(n.body),
                  trailing: n.read
                      ? null
                      : const Icon(Icons.circle,
                      size: 10, color: Colors.red),
                  onTap: () {
                    context.read<NotificationBloc>().add(
                      MarkAsRead(n.id),
                    );

                    NotificationNavigator.navigate(n.payload);
                  },
                );
              },
            );
          }

          return const Center(
            child: Text('No notifications yet'),
          );
        },
      ),
    );
  }
}
