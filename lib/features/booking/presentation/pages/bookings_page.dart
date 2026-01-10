import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../manager/booking_bloc.dart';
import '../manager/booking_state.dart';
import '../widgets/bookings_list.dart';
import '../widgets/skeleton/skeleton_list.dart';

class BookingsPage extends StatefulWidget {
    BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        bottom: TabBar(
          controller: controller,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Confirmed'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (_, state) {
          if (state is BookingLoading) {
            return const BookingListSkeleton();
            //Center(child: CircularProgressIndicator());
          }

          if (state is BookingError) {
            return Center(child: Text(state.message));
          }
          if (state is BookingEmpty) {
            return const Center(
              child: Text('No bookings yet'),
            );
          }

          if (state is BookingLoaded) {
            final pending = state.bookings.where((b) => b.status == 'pending').toList();

            final completed = state.bookings
                .where((b) => b.status == 'completed')
                .toList();

            final cancelled = state.bookings
                .where((b) => b.status == 'cancelled')
                .toList();

            final rejected = state.bookings
                .where((b) => b.status == 'rejected')
                .toList();

           final confirmed = state.bookings.where((b) => b.status == 'confirmed').toList();


            return TabBarView(
              controller: controller,
              children: [
                BookingsList(pending),
                BookingsList(confirmed),
                BookingsList(completed),
                BookingsList(cancelled),
                BookingsList(rejected),
              ],
            );

          }

          return const SizedBox();
        },
      ),
    );
  }
}
