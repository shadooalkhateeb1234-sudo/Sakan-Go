import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  void _submit() {
    if (startDate == null || endDate == null) {
      _showError('Please select start and end dates');
      return;
    }

    if (endDate!.isBefore(startDate!)) {
      _showError('End date must be after start date');
      return;
    }

    if (latitude == null || longitude == null) {
      _showError('Please allow location access');
      return;
    }

    if (selectedPayment == null) {
      _showError('Please select payment method');
      return;
    }

    context.read<BookingBloc>().add(
      CreateBookingEvent(
        apartment_id: widget.apartment_id,
        start_date: startDate!,
        end_date: endDate!,
        latitude: latitude!,
        longitude: longitude!,
        paymentMethod: selectedPayment!.value,
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
      appBar: AppBar(title: const Text('Create Booking')),
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
                  title: const Text('Start Date'),
                  subtitle:
                  Text(startDate?.toString().split(' ').first ?? 'Select'),
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
                  title: const Text('End Date'),
                  subtitle:
                  Text(endDate?.toString().split(' ').first ?? 'Select'),
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
                        'Total Price: $totalPrice',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // ================= LOCATION =================
                Text(
                  'Your Location',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),

                ElevatedButton.icon(
                  icon: loadingLocation
                      ? const SizedBox(
                    width: 16,
                    height: 16,
                    child:
                    CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Icon(Icons.location_on),
                  label: const Text('Allow Location Access'),
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
                  'Payment Method',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),

                ...PaymentMethod.values.map(
                      (method) => RadioListTile<PaymentMethod>(
                    title: Text(method.label),
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
                  child: const Text(
                    'No payment will be charged now.\n'
                        'Booking will be sent for owner approval.',
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
                        : const Text('Send Booking Request'),
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


// class CreateBookingPage extends StatefulWidget {
//   final int apartment_id;
//   final int user_id;
//
//   CreateBookingPage({
//     super.key,
//     required this.apartment_id,
//     required this.user_id,
//   });
//
//   @override
//   State<CreateBookingPage> createState() => _CreateBookingPageState();
// }
//
// class _CreateBookingPageState extends State<CreateBookingPage> {
//   DateTime? start_date;
//   DateTime? end_date;
//   PaymentMethod? selectedPayment;
//   double? lat;
//   double? lng;
//
//   Future<void> submit() async {
//     if (selectedPayment == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select payment method')),
//       );
//       return;
//
//     }
//     if (start_date == null || end_date == null) return;
//
//     try {
//       final position = await LocationService.getCurrentLocation();
//
//       setState(() {
//         lat = position.latitude;
//         lng = position.longitude;
//       });
//
//       context.read<BookingBloc>().add(
//           CreateBookingEvent(
//             apartment_id: widget.apartment_id,
//             start_date: start_date!,
//             end_date: end_date!,
//             latitude: position.latitude,
//             longitude: position.longitude,
//             paymentMethod: selectedPayment!.value,
//           )
//
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Create Booking')),
//       body: BlocConsumer<BookingBloc, BookingState>(
//         listener: (_, state) {
//           if (state is BookingActionSuccess) {
//             context.pop();
//           }
//           if (state is BookingError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (_, state) {
//           final loading = state is BookingLoading;
//           final price = (start_date != null && end_date != null)
//               ? (end_date!.difference(start_date!).inDays + 1) * 100
//               : null;
//
//           return Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   ListTile(
//                     title: const Text('Start Date'),
//                     subtitle: Text(start_date?.toString() ?? 'Select'),
//                     onTap: () async {
//                       final d = await showDatePicker(
//                         context: context,
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime.now().add(const Duration(days: 365)),
//                         initialDate: DateTime.now(),
//                       );
//                       if (d != null) setState(() => start_date = d);
//                     },
//                   ),
//                   ListTile(
//                     title: const Text('End Date'),
//                     subtitle: Text(end_date?.toString() ?? 'Select'),
//                     onTap: () async {
//                       final d = await showDatePicker(
//                         context: context,
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime.now().add(const Duration(days: 365)),
//                         initialDate: DateTime.now(),
//                       );
//                       if (d != null) setState(() => end_date = d);
//                       if (end_date!.isBefore(start_date!)) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('End date must be after start date')),
//                         );
//                         return;
//                       }
//
//                     },
//                   ),
//                   if (price != null)
//                     Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Total price: $price',
//                                 style: Theme
//                                     .of(context)
//                                     .textTheme
//                                     .titleMedium),
//                             const SizedBox(height: 6),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   if (lat != null && lng != null)
//                     LocationPreviewMap(lat: lat!, lng: lng!),
//
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.secondaryContainer,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: const [
//                         Icon(Icons.location_on_outlined),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             'Your current location will be attached to the booking request.',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Theme
//                           .of(context)
//                           .colorScheme
//                           .tertiaryContainer,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: const [
//                         Icon(Icons.info_outline),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             'No payment will be charged now.\n'
//                                 'Your booking will be sent for owner approval.',
//                           ),
//
//                         ),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Payment Method',
//                         style: Theme.of(context).textTheme.titleMedium,
//                       ),
//                       const SizedBox(height: 8),
//
//                       ...PaymentMethod.values.map(
//                             (method) => RadioListTile<PaymentMethod>(
//                           title: Text(method.label),
//                           value: method,
//                           groupValue: selectedPayment,
//                           onChanged: (value) {
//                             setState(() => selectedPayment = value);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     'Note: Payment details will be handled by the server after booking approval.',
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodySmall
//                         ?.copyWith(color: Theme.of(context).colorScheme.outline),
//                   ),
//
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: loading ? null : submit,
//                       child: loading
//                           ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       )
//                           : const Text('Confirm'),
//                     ),
//                   ),
//
//                 ],
//               )
//
//           );
//         },
//       ),
//     );
//   }
// }
// //...............
//