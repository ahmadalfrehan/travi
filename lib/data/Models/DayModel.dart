import 'package:project_one_maybe_clean_architecture/domain/entites/Day.dart';

class DayModel extends Day {
  DayModel({
    required super.name,
    required super.id,
    required super.created_at,
    required super.day,
    required super.updated_at,
    required super.descreption,
    required super.dailyprogram_id,
  });

  factory DayModel.fromJson(Map<dynamic, dynamic> json) {
    return DayModel(
      name: json['name'],
      id: json['id'],
      created_at: json['created_at'],
      day: json['day'],
      updated_at: json['updated_at'],
      descreption: json['description'],
      dailyprogram_id: json['dailyprogram_id'],
    );
  }
}
