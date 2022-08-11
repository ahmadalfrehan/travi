import 'package:project_one_maybe_clean_architecture/domain/entites/rating.dart';

class RatingModel extends Rating {
  RatingModel({
    required super.id,
    required super.updated_at,
    required super.created_at,
    required super.star,
    required super.comment,
    required super.rateable_id,
    required super.rateable_type,
    required super.user_id,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      updated_at: json['updated_at'],
      created_at: json['created_at'],
      star: json['star'],
      comment: json['comment'],
      rateable_id: json['rateable_id'],
      rateable_type: json['rateable_type'],
      user_id: json['user_id'],
    );
  }
}
