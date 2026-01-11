import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakan_go/core/localization/app_localizations.dart';
import '../../domain/entities/payment_method.dart';
import '../manager/booking_bloc.dart';
import '../manager/booking_event.dart';
import '../manager/booking_state.dart';
import '../widgets/date_card.dart';

class UpdateBookingPage extends StatefulWidget {
  final int booking_id;
  final DateTime initialStart;
  final DateTime initialEnd;

  const UpdateBookingPage({
    super.key,
    required this.booking_id,
    required this.initialStart,
    required this.initialEnd,
  });

  @override
  State<UpdateBookingPage> createState() => _UpdateBookingPageState();
}

class _UpdateBookingPageState extends State<UpdateBookingPage> {
  late DateTime startDate;
  late DateTime endDate;
  PaymentMethod? selectedPayment;

  @override
  void initState() {
    super.initState();
    startDate = widget.initialStart;
    endDate = widget.initialEnd;
  }

  Future<void> _pick(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: isStart ? startDate : endDate,
    );

    if (date != null) {
      setState(() => isStart ? startDate = date : endDate = date);
    }
  }

  void _submit() {
    if (selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('select_payment_method'.tr(context)),
        ),
      );
      return;
    }

    context.read<BookingBloc>().add(
      RequestBookingUpdateEvent(
        booking_id: widget.booking_id,
        startDate: startDate,
        endDate: endDate,
        paymentMethod: selectedPayment!.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit_booking'.tr(context)),
      ),
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingActionSuccess) {
            context.pop();
          }
          if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateCard(
                  title: 'start_date'.tr(context),
                  date: startDate,
                  onTap: () => _pick(true),
                ),
                DateCard(
                  title: 'end_date'.tr(context),
                  date: endDate,
                  onTap: () => _pick(false),
                ),

                const SizedBox(height: 16),

                Text(
                  'payment_method'.tr(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                ...PaymentMethod.values.map(
                      (method) => RadioListTile<PaymentMethod>(
                    title: Text(method.labelKey.tr(context)),
                    value: method,
                    groupValue: selectedPayment,
                    onChanged: (v) => setState(() => selectedPayment = v),
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text('save_changes'.tr(context)),
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
