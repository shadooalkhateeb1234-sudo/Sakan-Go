import 'package:flutter/material.dart';
import 'booking_card_skeleton.dart';

class BookingListSkeleton extends StatelessWidget {
  const BookingListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) => const BookingCardSkeleton(),
    );
  }
}
