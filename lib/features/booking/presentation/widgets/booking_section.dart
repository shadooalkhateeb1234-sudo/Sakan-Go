import '../../../../core/routing/routes_name.dart';
import '../../domain/entities/booking_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'booking_card.dart';

class BookingSection extends StatelessWidget {
  final String title;
  final List<BookingEntity> bookings;

  const BookingSection({
    super.key,
    required this.title,
    required this.bookings,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ...bookings.map(
              (booking) => BookingCard(
            booking: booking,
                onTap: () {
                  context.push(
                    RouteName.updateBooking,
                    extra: booking,
                  );
                },

              ),
        ),
      ],
    );
  }
}
