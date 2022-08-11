import 'package:project_one_maybe_clean_architecture/domain/entites/EventDetails.dart';

class EventDetailsModel extends EventDetails {
  EventDetailsModel({
    required super.events,
    required super.day,
  });

  factory EventDetailsModel.fromJson(Map<dynamic, dynamic> json) {
    return EventDetailsModel(
      events: json['events'],
      day: json['day'],
    );
  }
}
