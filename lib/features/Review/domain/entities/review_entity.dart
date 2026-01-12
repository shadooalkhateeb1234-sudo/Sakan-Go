//
// class ReviewEntity {
//   final int id;
//   final int stars;
//   final String? comment;
//   final int apartmentId;
// //final int bookingId;
// // final int userId;
//   ReviewEntity({
//     required this.id,
//     required this.stars,
//     this.comment,
//     required this.apartmentId,
//   });
// }
class ReviewEntity {
  final int id;
  final int bookingId;
  final int apartmentId;
  final int stars;
  final String? comment;

  ReviewEntity({
    required this.id,
    required this.bookingId,
    required this.apartmentId,
    required this.stars,
    this.comment,
  });
}
