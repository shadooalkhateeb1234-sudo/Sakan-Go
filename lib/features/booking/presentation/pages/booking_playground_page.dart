import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes_name.dart';
import '../manager/booking_bloc.dart';
import '../manager/booking_event.dart';

class BookingPlaygroundPage extends StatelessWidget {
  const BookingPlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Playground')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _ActionButton(
              title: '➕ Create Booking',
              onTap: () {
                context.push(
                  RouteName.createBooking,
                  extra: {
                    'apartmentId': 99,
                    'userId': 1,
                  },
                );
              },
            ),

            _ActionButton(
              title: '📋 My Bookings',
              onTap: () {
                context.push(RouteName.bookings);
              },
            ),

            _ActionButton(
              title: '✏️ Edit First Booking',
              onTap: () {
                // fake navigation – من BookingsList عملياً
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Edit from bookings list'),
                  ),
                );
              },
            ),

            _ActionButton(
              title: '❌ Cancel Booking',
              onTap: () {
                context.push(RouteName.Bookingcancel, extra: 1 );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(title),
        ),
      ),
    );
  }
}
//......

// class BookingPlaygroundPage extends StatelessWidget {
//   const BookingPlaygroundPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Booking Playground'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             /// ➕ CREATE BOOKING
//             ElevatedButton.icon(
//               icon: const Icon(Icons.add),
//               label: const Text('Create Booking'),
//               onPressed: () {
//                 context.push(
//                   RouteName.createBooking,
//                   extra: {
//                     'apartmentId': 1,
//                     'userId': 1,
//                   },
//                 );
//               },
//             ),
//
//             const SizedBox(height: 16),
//
//             /// 📋 MY BOOKINGS
//             ElevatedButton.icon(
//               icon: const Icon(Icons.list_alt),
//               label: const Text('My Bookings'),
//               onPressed: () {
//                 context.read<BookingBloc>().add(GetUserBookingsEvent());
//                 context.push(RouteName.bookings);
//               },
//             ),
//
//             const SizedBox(height: 16),
//
//             /// ❌ OWNER REJECT (TEST)
//             ElevatedButton.icon(
//               icon: const Icon(Icons.block),
//               label: const Text('Owner Reject Booking (ID = 1)'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.redAccent,
//               ),
//               onPressed: () {
//                 context.read<BookingBloc>().add(
//                   RejectBookingEvent(1),
//                 );
//               },
//             ),
//
//             const SizedBox(height: 16),
//
//             /// 🔄 REFRESH
//             OutlinedButton.icon(
//               icon: const Icon(Icons.refresh),
//               label: const Text('Reload Bookings'),
//               onPressed: () {
//                 context.read<BookingBloc>().add(GetUserBookingsEvent());
//               },
//             ),
//
//             const Spacer(),
//
//             /// ℹ️ NOTE
//             Text(
//               '• Booking starts as PENDING\n'
//                   '• No payment info required\n'
//                   '• Owner approval simulated',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodySmall
//                   ?.copyWith(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
