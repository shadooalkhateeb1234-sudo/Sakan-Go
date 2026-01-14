import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
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
      return   AlertDialog(
        content: Text('This_booking_cannot_be_cancelled'.tr(context)),
      );
    }

    return AlertDialog(
      title:   Text('cancel_booking'.tr(context)),
      content:   Text('Are_you_sure_you_want_to_cancel_this_booking?'.tr(context)),
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
