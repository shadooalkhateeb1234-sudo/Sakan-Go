import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../manager/booking_bloc.dart';
import '../manager/booking_event.dart';
import 'booking_permissions.dart';

class CancelBookingDialog extends StatelessWidget {
  final int booking_id;
  final String status;

  const CancelBookingDialog({
    super.key,
    required this.booking_id,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    if (!BookingStateMachine.can(status, BookingAction.cancel)) {
      return const AlertDialog(
        content: Text('This booking cannot be cancelled'),
      );
    }

    return AlertDialog(
      title: const Text('Cancel Booking'),
      content: const Text('Are you sure you want to cancel this booking?'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('No'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<BookingBloc>().add(
              CancelBookingEvent(booking_id),
            );
            context.pop();
          },
          child: const Text('Yes, Cancel'),
        ),
      ],
    );
  }
}
