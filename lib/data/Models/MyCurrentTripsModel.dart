import '../../domain/entites/MyCurrentTripsProfile.dart';

class MyCurrentTripsModel extends MyCurrentTripsProfile {
  MyCurrentTripsModel({
    required super.id,
    required super.image,
    required super.about,
    required super.name,
    required super.age,
    required super.coutinent,
    required super.createdAt,
    required super.dailyProgramId,
    required super.endTrip,
    required super.expireDate,
    required super.nameTeam,
    required super.offer,
    required super.price,
    required super.reiteration,
    required super.rest,
    required super.startDate,
    required super.startTrip,
    required super.total,
    required super.type,
    required super.updatedAt,
    required super.pivot,
  });

  factory MyCurrentTripsModel.fromJson(Map<dynamic, dynamic> json) {
    return MyCurrentTripsModel(
      id: json['id'],
      image: json['image'],
      about: json['about'],
      name: json['name'],
      age: json['age'],
      coutinent: json['coutinent'],
      createdAt: json['created_at'],
      dailyProgramId: json['dailyprogram_id'],
      endTrip: json['end_trip'],
      expireDate: json['expiry_date'],
      nameTeam: json['name_team'],
      offer: json['offer'],
      price: json['price'],
      reiteration: json['reiteration'],
      rest: json['rest'],
      startDate: json['start_date'],
      startTrip: json['start_trip'],
      total: json['total'],
      type: json['type'],
      updatedAt: json['updated_at'],
      pivot: json['pivot'],
    );
  }
}
