import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
import '../manager/owner_booking_bloc.dart';

class OwnerApprovalPage extends StatelessWidget {
  const OwnerApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocBuilder<OwnerBookingBloc, OwnerBookingState>(
      builder: (context, state) {
        if (state is OwnerBookingLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OwnerBookingLoaded) {
          if (state.bookings.isEmpty) {
            return Center(
              child: Text('no_booking_requests'.tr(context)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.bookings.length,
            itemBuilder: (_, i) {
              final b = state.bookings[i];

              return Card(
                child: ListTile(
                  title: Text(
                    '${'apartment'.tr(context)} ${b.apartment_id}',
                  ),
                  subtitle: Text(
                    '${b.startDate.toLocal()} → ${b.endDate.toLocal()}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: scheme.primary),
                        onPressed: () {
                          context
                              .read<OwnerBookingBloc>()
                              .add(ApproveBookingEvent(b.id));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: scheme.error),
                        onPressed: () {
                          context
                              .read<OwnerBookingBloc>()
                              .add(RejectBookingEvent(b.id));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (state is OwnerBookingError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
