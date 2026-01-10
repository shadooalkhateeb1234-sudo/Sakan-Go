import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/owner_booking_bloc.dart';


class OwnerApprovalPage extends StatelessWidget {
  const OwnerApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

  return BlocListener<OwnerBookingBloc, OwnerBookingState>(
        listener: (context, state) {
    if (state is OwnerBookingActionSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Action completed')),
      );
    }
  },

      child: BlocBuilder<OwnerBookingBloc, OwnerBookingState>(
      builder: (_, state) {
        if (state is OwnerBookingLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is OwnerBookingActionLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OwnerBookingLoaded) {
          if (state.bookings.isEmpty) {
            return const Center(child: Text('No booking requests'));
          }


          return ListView.builder(
            itemCount: state.bookings.length,
            itemBuilder: (_, i) {
              final b = state.bookings[i];

              return Card(
                child: ListTile(
                  title: Text('Apartment ${b.apartment_id}'),
                  subtitle: Text('${b.startDate} → ${b.endDate}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(

                        icon:Icon(Icons.check, color: scheme.primary),
                        onPressed: () => context
                            .read<OwnerBookingBloc>()
                            .add(ApproveBookingEvent(b.id)),
                      ),
                      IconButton(
                        icon:Icon(Icons.close, color: scheme.error),
                        onPressed: () => context
                            .read<OwnerBookingBloc>()
                            .add(RejectBookingEvent(b.id)),
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
    ),
  );

  }
}
