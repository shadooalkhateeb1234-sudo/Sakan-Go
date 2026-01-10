import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/owner_booking_bloc.dart';
import 'owner_approval_page.dart';
import 'owner_update_requests_page.dart';

class OwnerBookingsTabsPage extends StatefulWidget {
  const OwnerBookingsTabsPage({super.key});

  @override
  State<OwnerBookingsTabsPage> createState() =>
      _OwnerBookingsTabsPageState();
}

class _OwnerBookingsTabsPageState extends State<OwnerBookingsTabsPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);


    context.read<OwnerBookingBloc>().add(
      LoadOwnerBookings(),
    );

    context.read<OwnerBookingBloc>().add(
      LoadOwnerUpdateRequests(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Bookings'),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: scheme.primary,
          tabs: const [
            Tab(
              icon: Icon(Icons.home_work_outlined),
              text: 'Bookings',
            ),
            Tab(
              icon: Icon(Icons.edit_calendar_outlined),
              text: 'Updates',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          OwnerApprovalPage(),
          OwnerUpdateRequestsPage(),
        ],
      ),
    );
  }
}

