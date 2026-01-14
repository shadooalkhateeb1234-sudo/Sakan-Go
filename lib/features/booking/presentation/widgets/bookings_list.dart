import 'package:sakan_go/core/localization/app_localizations.dart';
import '../../../../core/routing/routes_name.dart';
import '../../domain/entities/booking_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'booking_card.dart';

class BookingsList extends StatelessWidget {
  final List<BookingEntity> bookings;
  const BookingsList(this.bookings, {super.key});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(child: Text('No_bookings'.tr(context)));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => BookingCard(
        booking: bookings[i],
        onTap: () {
          context.push(RouteName.updateBooking, extra: bookings[i]);
          },
      ),
    );


  }
}
