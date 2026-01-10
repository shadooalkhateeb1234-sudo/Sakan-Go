
import '../../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getApprovedBookings(String apartmentId);
  Future<void> createBooking(BookingModel booking);
}

// class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
//   final FirebaseFirestore firestore;
//
//   BookingRemoteDataSourceImpl(this.firestore);
//
//   @override
//   Future<List<BookingModel>> getApprovedBookings(String apartmentId) async {
//     final snapshot = await firestore
//         .collection('bookings')
//         .where('apartmentId', isEqualTo: apartmentId)
//         .where('approved', isEqualTo: true)
//         .get();
//
//     return snapshot.docs
//         .map((e) => BookingModel.fromJson(e.data()))
//         .toList();
//   }
//
//   @override
//   Future<void> createBooking(BookingModel booking) async {
//     await firestore.collection('bookings').add(booking.toJson());
//   }
// }
