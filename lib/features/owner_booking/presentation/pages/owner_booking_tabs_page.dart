import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
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

    final bloc = context.read<OwnerBookingBloc>();
    bloc.add(LoadOwnerBookings());
    bloc.add(LoadOwnerUpdateRequests());
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
        title: Text('owner_bookings'.tr(context)),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: scheme.primary,
          tabs: [
            Tab(
              icon: const Icon(Icons.home_work_outlined),
              text: 'bookings'.tr(context),
            ),
            Tab(
              icon: const Icon(Icons.edit_calendar_outlined),
              text: 'updates'.tr(context),
            ),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          OwnerApprovalPage(),
          OwnerUpdateRequestsPage(),
        ],
      ),
    );
  }
}
