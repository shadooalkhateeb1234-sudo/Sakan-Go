import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../booking/domain/entities/booking_update_request_entity.dart';
import '../manager/owner_booking_bloc.dart';

class OwnerUpdateRequestsPage extends StatefulWidget {
  const OwnerUpdateRequestsPage({super.key});

  @override
  State<OwnerUpdateRequestsPage> createState() =>
      _OwnerUpdateRequestsPageState();
}

class _OwnerUpdateRequestsPageState extends State<OwnerUpdateRequestsPage> {
  @override
  void initState() {
    super.initState();
    context.read<OwnerBookingBloc>().add(
      LoadOwnerUpdateRequests(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Requests')),
      body: BlocBuilder<OwnerBookingBloc, OwnerBookingState>(
        builder: (context, state) {
          if (state is OwnerUpdateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OwnerUpdateLoaded) {
            if (state.requests.isEmpty) {
              return const Center(child: Text('No update requests'));
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
      ),
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
              'Booking #${request.booking_id}',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 8),

            /// DATE RANGE
            Text(
              'New dates:',
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
                  icon: const Icon(Icons.close, color: Colors.red),
                  label: const Text('Reject'),
                  onPressed: () {
                    context.read<OwnerBookingBloc>().add(
                      RejectUpdateRequestEvent(request.id),
                    );
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Approve'),
                  onPressed: () {
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
