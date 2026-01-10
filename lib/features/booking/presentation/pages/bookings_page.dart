import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../manager/booking_bloc.dart';
import '../widgets/booking_card.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(GetBookingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BookingError) {
            return Center(child: Text(state.message));
          }

          if (state is BookingLoaded) {
            return ListView.builder(
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final booking = state.bookings[index];
                return BookingCard(booking: booking);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
