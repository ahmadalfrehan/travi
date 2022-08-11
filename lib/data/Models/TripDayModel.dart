import '../../domain/entites/TripDays.dart';

class TripDaysModel extends TripDays {
  TripDaysModel({
    required super.days,
    required super.daysNumber,
  });

  factory TripDaysModel.fromJson(Map<dynamic, dynamic> json) {
    return TripDaysModel(
      days: json['days'],
      daysNumber: json['daysNumber'],
    );
  }
}
