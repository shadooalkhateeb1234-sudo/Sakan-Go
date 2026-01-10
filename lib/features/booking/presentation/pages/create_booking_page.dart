import '../../domain/entities/booking_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../manager/booking_bloc.dart';


class CreateBookingPage extends StatefulWidget {
  final String apartmentId;

  const CreateBookingPage({super.key, required this.apartmentId});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  DateTime? start;
  DateTime? end;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Booking')),
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingConflict) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Booking conflict detected')),
            );
          }
          if (state is BookingSuccess) {
            context.pop();
          }
        },
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                start = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: DateTime.now(),
                );
              },
              child: const Text('Select Start Date'),
            ),
            ElevatedButton(
              onPressed: () async {
                end = await showDatePicker(
                  context: context,
                  firstDate: start ?? DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: start ?? DateTime.now(),
                );
              },
              child: const Text('Select End Date'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<BookingBloc>().add(
                  CreateBookingEvent(
                    BookingEntity(
                      id: '',
                      apartmentId: widget.apartmentId,
                      userId: '',
                      startDate: start!,
                      endDate: end!,
                      status: 'pending',
                    ),
                  ),
                );
              },
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
