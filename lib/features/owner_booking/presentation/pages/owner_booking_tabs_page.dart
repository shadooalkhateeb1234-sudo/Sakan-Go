import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
import '../manager/owner_booking_bloc.dart';
import 'owner_approval_page.dart';
import 'owner_update_requests_page.dart';

class OwnerBookingsTabsPage extends StatefulWidget {
  final int initialTab;

  const OwnerBookingsTabsPage({
    super.key,
    this.initialTab = 0,
  });

  @override
  State<OwnerBookingsTabsPage> createState() =>
      _OwnerBookingsTabsPageState();
}

class _OwnerBookingsTabsPageState extends State<OwnerBookingsTabsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab,
    );

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

    return BlocBuilder<OwnerBookingBloc, OwnerBookingState>(
      builder: (context, state) {
        int bookingsCount = 0;
        int updatesCount = 0;

        if (state is OwnerBookingCounters) {
          bookingsCount = state.bookingsCount;
          updatesCount = state.updatesCount;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('owner_bookings'.tr(context)),
            bottom: TabBar(
              controller: _controller,
              indicatorColor: scheme.primary,
              tabs: [
                _buildTabBadge(
                  icon: Icons.home_work_outlined,
                  label: 'bookings'.tr(context),
                  count: bookingsCount,
                  color: scheme.primary,
                ),
                _buildTabBadge(
                  icon: Icons.edit_calendar_outlined,
                  label: 'updates'.tr(context),
                  count: updatesCount,
                  color: scheme.error,
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
      },
    );
  }
}

Widget _buildTabBadge({
  required IconData icon,
  required String label,
  required int count,
  required Color color,
}) {
  return Tab(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon),
            if (count > 0)
              Positioned(
                right: -6,
                top: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    count.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    ),
  );
}
