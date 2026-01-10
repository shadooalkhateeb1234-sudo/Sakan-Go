import 'package:flutter/material.dart';

class BookingCardSkeleton extends StatelessWidget {
  const BookingCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                _skeletonBox(
                  width: 90,
                  height: 28,
                  radius: 20,
                  color: scheme.surfaceVariant,
                ),
                const Spacer(),
                _skeletonBox(
                  width: 24,
                  height: 24,
                  radius: 8,
                  color: scheme.surfaceVariant,
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// Date range
            _skeletonBox(
              width: double.infinity,
              height: 14,
              color: scheme.surfaceVariant,
            ),

            const SizedBox(height: 10),

            /// Apartment
            _skeletonBox(
              width: 160,
              height: 16,
              color: scheme.surfaceVariant,
            ),

            const SizedBox(height: 8),

            /// Hint
            _skeletonBox(
              width: 120,
              height: 12,
              color: scheme.surfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _skeletonBox({
    required double width,
    required double height,
    double radius = 12,
    required Color color,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
