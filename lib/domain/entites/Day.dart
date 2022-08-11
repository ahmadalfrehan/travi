class Day {
  int? id;
  String? name;
  String? descreption;
  String? day;
  int? dailyprogram_id;
  String? created_at;
  String? updated_at;

  Day({
    required this.name,
    required this.id,
    required this.created_at,
    required this.day,
    required this.updated_at,
    required this.descreption,
    required this.dailyprogram_id,
  });
}
