import '../../domain/entities/booking_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../manager/booking_bloc.dart';


class EditBookingPage extends StatefulWidget {
  final BookingEntity booking;

  const EditBookingPage({super.key, required this.booking});

  @override
  State<EditBookingPage> createState() => _EditBookingPageState();
}

class _EditBookingPageState extends State<EditBookingPage> {
  late DateTime start;
  late DateTime end;

  @override
  void initState() {
    super.initState();
    start = widget.booking.startDate;
    end = widget.booking.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Booking')),
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
            Text('From $start to $end'),
            ElevatedButton(
              onPressed: () {
                context.read<BookingBloc>().add(
                  UpdateBookingEvent(
                    bookingId: widget.booking.id,
                    newStart: start,
                    newEnd: end,
                  ),
                );
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
