import '../widgets/booking_card.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes_name.dart';
import '../../domain/entities/booking_entity.dart';
import 'package:flutter/material.dart';

class BookingsList extends StatelessWidget {
  final List<BookingEntity> bookings;

  const BookingsList(this.bookings, {super.key});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return const Center(child: Text('No bookings'));
    }

    return ListView.separated(
     padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => BookingCard(
        booking: bookings[i],
        onTap: () {
          context.push(
            RouteName.updateBooking,
            extra: bookings[i],
          );
        },
      ),
    );
  }
}

