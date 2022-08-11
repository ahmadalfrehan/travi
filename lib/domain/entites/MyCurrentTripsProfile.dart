class MyCurrentTripsProfile {
  int? id;
  int? dailyProgramId;
  String? name;
  String? age;
  String? type;
  int? price;
  int? offer;
  String? startDate;
  String? expireDate;
  String? startTrip;
  String? endTrip;
  int? rest;
  int? total;
  String? image;
  int? reiteration;
  String? coutinent;
  String? nameTeam;
  String? about;
  String? createdAt;
  String? updatedAt;
  Map<String, dynamic>? pivot;

  MyCurrentTripsProfile({
    required this.id,
    required this.image,
    required this.about,
    required this.name,
    required this.age,
    required this.coutinent,
    required this.createdAt,
    required this.dailyProgramId,
    required this.endTrip,
    required this.expireDate,
    required this.nameTeam,
    required this.offer,
    required this.price,
    required this.reiteration,
    required this.rest,
    required this.startDate,
    required this.startTrip,
    required this.total,
    required this.type,
    required this.updatedAt,
    required this.pivot,
  });
}
