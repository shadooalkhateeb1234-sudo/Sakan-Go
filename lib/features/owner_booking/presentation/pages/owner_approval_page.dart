import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
import '../manager/owner_booking_bloc.dart';
import 'package:intl/intl.dart';



class OwnerApprovalPage extends StatelessWidget {
  const OwnerApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final f = DateFormat('dd MMM yyyy');

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
            itemBuilder: (context, i) {
              final b = state.bookings[i];

              return Card(
                child: ListTile(
                  title: Text(
                    '${'apartment'.tr(context)} ${b.apartment_id}',
                  ),
                  subtitle: Text(
                    '${f.format(b.startDate)} → ${f.format(b.endDate)}',
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