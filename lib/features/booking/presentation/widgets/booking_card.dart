import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/routing/routes_name.dart';
import '../../domain/entities/booking_entity.dart';


class BookingCard extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback? onTap;

  const BookingCard({
    super.key,
    required this.booking,
    this.onTap,
  });

  // ================= STATUS COLOR =================
  Color _statusColor(ColorScheme scheme) {
    switch (booking.status) {
      case 'confirmed':
        return scheme.primary;
      case 'completed':
        return Colors.green;
      case 'cancelled':
      case 'rejected':
        return scheme.error;
      case 'pending':
      default:
        return scheme.tertiary;
    }
  }

  // ================= STATUS TEXT =================
  String _statusHint() {
    switch (booking.status) {
      case 'pending':
        return 'Waiting owner approval';
      case 'confirmed':
        return 'Booking confirmed by owner';
      case 'completed':
        return 'Booking completed';
      case 'cancelled':
        return 'Booking cancelled';
      case 'rejected':
        return 'Rejected by owner';
      default:
        return '';
    }
  }

  // ================= STATUS ICON =================
  IconData _statusIcon() {
    switch (booking.status) {
      case 'confirmed':
        return Icons.check_circle;
      case 'completed':
        return Icons.verified;
      case 'cancelled':
      case 'rejected':
        return Icons.cancel;
      case 'pending':
      default:
        return Icons.hourglass_bottom;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = _statusColor(scheme);
    final dateFormat = DateFormat('dd MMM yyyy');

    /// edit only if pending or confirmed
    final canEdit =
        booking.status == 'pending' || booking.status == 'confirmed';

    /// rate only if completed
    final canRate = booking.status == 'completed';

    return InkWell(
      onTap: canEdit ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= STATUS =================
              Row(
                children: [
                  Chip(
                    avatar: Icon(
                      _statusIcon(),
                      size: 16,
                      color: color,
                    ),
                    label: Text(
                      booking.status.toUpperCase(),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: color.withOpacity(.12),
                    side: BorderSide(color: color.withOpacity(.4)),
                  ),
                  const Spacer(),
                  if (canEdit)
                    Icon(
                      Icons.edit,
                      size: 18,
                      color: scheme.primary,
                    ),
                ],
              ),

              const SizedBox(height: 10),

              // ================= DATE RANGE =================
              Text(
                '${dateFormat.format(booking.start_date)} → '
                    '${dateFormat.format(booking.end_date)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),

              const SizedBox(height: 6),

              // ================= APARTMENT =================
              Text(
                'Apartment #${booking.apartment_id}',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 6),

              // ================= PRICE =================
              Text(
                'Total price: ${booking.total_price}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              // ================= STATUS HINT =================
              Text(
                _statusHint(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.outline),
              ),

              // ================= RATE =================
              if (canRate) ...[
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.star, color: Colors.amber),
                  label: const Text('Rate apartment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scheme.surfaceVariant,
                    foregroundColor: scheme.onSurface,
                    elevation: 0,
                  ),
                  onPressed: () {
                    context.push(
                      RouteName.createReview,
                      extra: booking.id,
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
