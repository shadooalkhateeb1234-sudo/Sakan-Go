import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
import '../../../../core/routing/routes_name.dart';
import '../../domain/entities/booking_entity.dart';
import 'package:intl/intl.dart';
import '../widgets/booking_permissions.dart';

class BookingDetailsPage extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailsPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd MMM yyyy');

    return Scaffold(

      appBar: AppBar(
        title: Text('booking_details'.tr(context)),
        actions: [
          if (BookingStateMachine.can(booking.status, BookingAction.reviewRate))
            ElevatedButton.icon(
              icon: const Icon(Icons.star),
              label: Text('rate_apartment'.tr(context)),
              onPressed: () {
                context.push(RouteName.createReview, extra: booking.id);
              },
            ),

          if (BookingStateMachine.can(booking.status, BookingAction.edit))
            ElevatedButton(
              onPressed: () {
                context.push(RouteName.updateBooking, extra: booking);
              },
              child: Text('edit_booking'.tr(context)),
            ),

          if (BookingStateMachine.can(booking.status, BookingAction.cancel))
            OutlinedButton(
              onPressed: () {
                context.push('/booking/cancel/${booking.id}');
              },
              child: Text('cancel_booking'.tr(context)),
            ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apartment #${booking.apartment_id}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text('From: ${f.format(booking.start_date)}'),
            Text('To: ${f.format(booking.end_date)}'),
            const SizedBox(height: 12),
            Chip(label: Text(booking.status.toUpperCase())),
          //this must be changed
            if (BookingStateMachine.can(booking.status, BookingAction.isFinal))
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'This booking can no longer be modified.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
