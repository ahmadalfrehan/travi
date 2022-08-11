class Areas {
  int? id;
  String? name;
  String? country;
  String? city;
  String? lat;
  String? lag;
  String? image1;
  String? image2;
  String? image3;
  String? description;
  String? createdAt;
  String? updatedAt;
  Map<String, int>? pivot;

  Areas({
    required this.id,
    required this.pivot,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.image3,
    required this.image2,
    required this.image1,
    required this.lat,
    required this.lag,
    required this.name,
    required this.city,
    required this.country,
  });
}
