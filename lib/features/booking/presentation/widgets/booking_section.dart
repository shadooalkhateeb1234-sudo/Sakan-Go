import 'package:flutter/material.dart';
import '../../domain/entities/booking_entity.dart';
import 'animated_booking_card.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/booking_entity.dart';
import '../widgets/booking_card.dart';

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
        ...bookings.map((b) => BookingCard(
          booking: booking,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookingDetailsPage(booking: booking),
              ),
            );
          },
        )
        ),
      ],
    );
  }
}

// class  Section extends StatelessWidget {
//   final String title;
//   final List<BookingEntity> bookings;
//
//   const  Section({
//     required this.title,
//     required this.bookings,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     if (bookings.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           child: Text(
//             title.toUpperCase(),
//             style: theme.textTheme.titleSmall?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: theme.colorScheme.primary,
//               letterSpacing: 1.2,
//             ),
//           ),
//         ),
//         ...bookings.map(
//               (booking) =>  AnimatedBookingCard(
//             booking: booking,
//           ),
//         ),
//       ],
//     );
//   }
// }
