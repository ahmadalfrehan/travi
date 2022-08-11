import 'package:project_one_maybe_clean_architecture/domain/entites/areas.dart';

class AreasModel extends Areas {
  AreasModel({
    required super.id,
    required super.pivot,
    required super.createdAt,
    required super.updatedAt,
    required super.description,
    required super.image3,
    required super.image2,
    required super.image1,
    required super.lat,
    required super.lag,
    required super.name,
    required super.city,
    required super.country,
  });

  factory AreasModel.fromJson(Map<dynamic, dynamic> json) {
    return AreasModel(
      id: json['id'],
      pivot: json['pivot'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      description: json['description'],
      image3: json['image3'],
      image2: json['image2'],
      image1: json['image1'],
      lat: json['latitude'],
      lag: json['longitude'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
    );
  }
}
