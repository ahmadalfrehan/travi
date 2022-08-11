import 'package:project_one_maybe_clean_architecture/data/Models/anotherTripModel.dart';
import 'package:project_one_maybe_clean_architecture/domain/entites/DetailsTrip.dart';

class DetailsTripModel extends DetailsTrip {
  DetailsTripModel({
    required super.tripDetails,
    required super.average,
    required super.activities,
  });

  factory DetailsTripModel.fromJson(Map<dynamic, dynamic> json) {
    return DetailsTripModel(
      tripDetails: AnotherTripModel.fromJson(json['details']),
      average: json['avg_rate'],
      activities: json['activities'],
    );
  }
}
