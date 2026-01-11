import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
import '../../../booking/domain/entities/booking_update_request_entity.dart';
import '../manager/owner_booking_bloc.dart';


class OwnerUpdateRequestsPage extends StatelessWidget {
  const OwnerUpdateRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerBookingBloc, OwnerBookingState>(
      builder: (context, state) {
        if (state is OwnerUpdateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OwnerUpdateLoaded) {
          if (state.requests.isEmpty) {
            return Center(
              child: Text('no_update_requests'.tr(context)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.requests.length,
            itemBuilder: (_, i) =>
                _UpdateRequestCard(request: state.requests[i]),
          );
        }

        if (state is OwnerUpdateError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _UpdateRequestCard extends StatelessWidget {
  final BookingUpdateRequestEntity request;

  const _UpdateRequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                Chip(
                  label: Text(
                    request.status.toUpperCase(),
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: scheme.primary.withOpacity(.12),
                ),
                const Spacer(),
                const Icon(Icons.edit_calendar_outlined),
              ],
            ),

            const SizedBox(height: 10),

            /// BOOKING ID
            Text(
              '${'booking'.tr(context)} #${request.booking_id}',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 8),

            /// DATE RANGE
            Text(
              'new_dates'.tr(context),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              '${request.update_start_date} → ${request.update_end_date}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 12),

            /// ACTIONS
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.close, color: scheme.error),
                  label: Text('reject'.tr(context)),
                  onPressed: () {
                    context.read<OwnerBookingBloc>().add(
                      RejectUpdateRequestEvent(request.id),
                    );
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: Text('approve'.tr(context)),
                  onPressed: request.status != 'pending'
                      ? null
                      : () {
                    context.read<OwnerBookingBloc>().add(
                      ApproveUpdateRequestEvent(request.id),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
