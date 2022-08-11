import '../../domain/entites/Events.dart';

class EventModel extends Events {
  EventModel({
    required super.name,
    required super.id,
    required super.created_at,
    required super.image,
    required super.timing,
    required super.updated_at,
    required super.descreption,
    required super.dailyprogram_id,
  });

  factory EventModel.fromJson(Map<dynamic, dynamic> json) {
    return EventModel(
      name: json['name'],
      id: json['id'],
      created_at: json['created_at'],
      image: json['image'],
      timing: json['timing'],
      updated_at: json['updated_at'],
      descreption: json['description'],
      dailyprogram_id: json['dateday_id'],
    );
  }
}
