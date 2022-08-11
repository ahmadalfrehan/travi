class Events {
  int? id;
  String? name;
  String? descreption;
  String? timing;
  int? dailyprogram_id;
  String image;
  String? created_at;
  String? updated_at;

  Events({
    required this.name,
    required this.id,
    required this.created_at,
    required this.image,
    required this.timing,
    required this.updated_at,
    required this.descreption,
    required this.dailyprogram_id,
  });
}
