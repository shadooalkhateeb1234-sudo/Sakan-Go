
class ReviewEntity {
  final int id;
  final int stars;
  final String? comment;
  final int apartmentId;

  ReviewEntity({
    required this.id,
    required this.stars,
    this.comment,
    required this.apartmentId,
  });
}
