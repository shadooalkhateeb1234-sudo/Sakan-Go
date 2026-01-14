import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
import 'package:sakan_go/features/booking/domain/entities/payment_entity.dart';
import '../../../../core/location/location_service.dart';
import '../../../../core/widget/location_preview_map.dart';
import '../../domain/entities/payment_method.dart';
import '../manager/booking_event.dart';
import '../manager/booking_state.dart';
import 'package:flutter/material.dart';
import '../manager/booking_bloc.dart';


class CreateBookingPage extends StatefulWidget {
  final int apartment_id;
  final int user_id;

  const CreateBookingPage({
    super.key,
    required this.apartment_id,
    required this.user_id,
  });

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  DateTime? startDate;
  DateTime? endDate;

  PaymentMethod? selectedPayment;

  double? latitude;
  double? longitude;

  bool loadingLocation = false;

  // ================= LOCATION =================
  Future<void> _getLocation() async {
    try {
      setState(() => loadingLocation = true);

      final position = await LocationService.getCurrentLocation();

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => loadingLocation = false);
    }
  }

  // ================= SUBMIT =================
  // ================= SUBMIT =================
  void _submit() {
    if (startDate == null || endDate == null) {
      _showError('select_dates_error'.tr(context));
      return;
    }

    if (endDate!.isBefore(startDate!)) {
      _showError('end_date_error'.tr(context));
      return;
    }

    if (latitude == null || longitude == null) {
      _showError('location_required'.tr(context));
      return;
    }

    if (selectedPayment == null) {
      _showError('payment_required'.tr(context));
      return;
    }

   // final totalPrice = (endDate!.difference(startDate!).inDays + 1) * 100;

    context.read<BookingBloc>().add(
      CreateBookingEvent(
        apartment_id: widget.apartment_id,
        start_date: startDate!,
        end_date: endDate!,
        latitude: latitude!,
        longitude: longitude!,
        paymentMethod: selectedPayment!,
      ),
    );

  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create_booking'.tr(context))),
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (_, state) {
          if (state is BookingActionSuccess) {
            context.pop();
          }

          if (state is BookingError) {
            _showError(state.message);
          }
        },
        builder: (_, state) {
          final loading = state is BookingLoading;

          final totalPrice = (startDate != null && endDate != null)
              ? (endDate!.difference(startDate!).inDays + 1) * 100
              : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= DATES =================
                ListTile(
                  title: Text('start_date'.tr(context)),
                  subtitle: Text(
                  startDate?.toString().split(' ').first ?? 'select'.tr(context),
                  ),
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate:
                      DateTime.now().add(const Duration(days: 365)),
                      initialDate: DateTime.now(),
                    );
                    if (d != null) setState(() => startDate = d);
                  },
                ),
                ListTile(
                  title: Text('end_date'.tr(context)),
                  subtitle: Text(
                    endDate?.toString().split(' ').first ?? 'select'.tr(context),
                  ),
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate:
                      DateTime.now().add(const Duration(days: 365)),
                      initialDate: DateTime.now(),
                    );
                    if (d != null) setState(() => endDate = d);
                  },
                ),

                if (totalPrice != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        '${'total_price_label'.tr(context)}: $totalPrice',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),


                const SizedBox(height: 16),

                // ================= LOCATION =================
                Text(
                  'your_location'.tr(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: loadingLocation
                      ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Icon(Icons.location_on),
                  label: Text('allow_location'.tr(context)),
                  onPressed: loadingLocation ? null : _getLocation,
                ),

                if (latitude != null && longitude != null) ...[
                  const SizedBox(height: 8),
                  LocationPreviewMap(
                    lat: latitude!,
                    lng: longitude!,
                  ),
                ],

                const SizedBox(height: 16),

                // ================= PAYMENT =================
                Text(
                  'payment_method'.tr(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),

                ...PaymentMethod.values.map(
                      (method) => RadioListTile<PaymentMethod>(
                    title: Text(method.labelKey.tr(context)),
                    value: method,
                    groupValue: selectedPayment,
                    onChanged: (v) => setState(() => selectedPayment = v),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                    Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'no_payment_now'.tr(context),
                  ),
                ),

                const SizedBox(height: 16),

                // ================= SUBMIT =================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : _submit,
                    child: loading
                        ? const CircularProgressIndicator()
                        :   Text('send_booking_request'.tr(context)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
