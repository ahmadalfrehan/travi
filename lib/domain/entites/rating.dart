class Rating {
  int? id;
  int? star;
  String? comment;

  String? created_at;
  String? updated_at;
  String? rateable_type;
  int? rateable_id;
  int? user_id;

  Rating({
    required this.id,
    required this.updated_at,
    required this.created_at,
    required this.star,
    required this.comment,
    required this.rateable_id,
    required this.rateable_type,
    required this.user_id,
  });
}
