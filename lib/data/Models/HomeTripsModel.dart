import 'package:project_one_maybe_clean_architecture/data/Models/UserModel.dart';
import 'package:project_one_maybe_clean_architecture/domain/entites/HomeTrips.dart';

class HomeTripsModel extends HomeTrips {
  HomeTripsModel({
    required super.user,
    super.offered,
    super.recommended,
    super.best,
  });

  factory HomeTripsModel.fromJson(Map<dynamic, dynamic> json) {
    return HomeTripsModel(
      user: UserModel.fromJson(json['user']),
      offered: json['\$offerdTrips'],
      best: json['best trip'],
      recommended: json['recommended'],
      //best: TripModel.fromJson(json['best trip']),
    );
  }
}
