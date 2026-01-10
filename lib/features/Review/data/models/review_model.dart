import '../../domain/entities/review_entity.dart';


class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.id,
    required super.stars,
    super.comment,
    required super.apartmentId,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      stars: json['stars'],
      comment: json['comment'],
      apartmentId: json['apartment']['id'],
    );
  }
}
