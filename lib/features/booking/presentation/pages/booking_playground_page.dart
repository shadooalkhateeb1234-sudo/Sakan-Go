import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes_name.dart';

class BookingPlaygroundPage extends StatelessWidget {
  const BookingPlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Playground'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ActionButton(
            icon: Icons.add,
            title: 'Create Booking',
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
            icon: Icons.list_alt,
            title: 'My Bookings',
            onTap: () {
              context.push(RouteName.bookings);
            },
          ),

          _ActionButton(
            icon: Icons.star,
            title: 'Create Review (booking #1)',
            onTap: () {
              context.push(
                 '/createReview/12/99' ,
              );
            },
          ),

          _ActionButton(
            icon: Icons.cancel,
            title: 'Cancel Booking ',
            onTap: () {
              context.push(RouteName.Bookingcancel);
            },
          ),

          _ActionButton(
            icon: Icons.notifications,
            title: 'Notification',
            onTap: () {
              context.go('/notifications');
            },
          ),
          _ActionButton(
            icon: Icons.admin_panel_settings,
            title: 'Owner Bookings',
            onTap: () {
              context.push(RouteName.Ownerbookings);
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: 52,
        child: ElevatedButton.icon(
          icon: Icon(icon),
          label: Text(title),
          onPressed: onTap,
        ),
      ),
    );
  }
}
//
// class BookingPlaygroundPage extends StatelessWidget {
//   const BookingPlaygroundPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Booking Playground')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _ActionButton(
//               title: '➕ Create Booking',
//               onTap: () {
//                 context.push(
//                   RouteName.createBooking,
//                   extra: {
//                     'apartmentId': 99,
//                     'userId': 1,
//                   },
//                 );
//               },
//             ),
//
//             _ActionButton(
//               title: '📋 My Bookings',
//               onTap: () {
//                 context.push(RouteName.bookings);
//               },
//             ),
//
//             _ActionButton(
//               title: '✏️ Edit First Booking',
//               onTap: () {
//                 // fake navigation – من BookingsList عملياً
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Edit from bookings list'),
//                   ),
//                 );
//               },
//             ),
//
//             _ActionButton(
//               title: '❌ Cancel Booking',
//               onTap: () {
//                 context.push(RouteName.Bookingcancel, extra: 1 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _ActionButton extends StatelessWidget {
//   final String title;
//   final VoidCallback onTap;
//
//   const _ActionButton({
//     required this.title,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           onPressed: onTap,
//           child: Text(title),
//         ),
//       ),
//     );
//   }
// }
