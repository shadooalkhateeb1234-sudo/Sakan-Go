import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/cancel_booking_dialog.dart';

class CancelBookingPage extends StatelessWidget {
  final int bookingId;

  const CancelBookingPage({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (_) => CancelBookingDialog(booking_id: bookingId, status: 'cancelled',),
      ).then((_) => context.pop());
    });

    return const Scaffold(
      body: SizedBox.shrink(),
    );
  }
}

