import 'package:project_one_maybe_clean_architecture/domain/entites/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.Birth,
    super.password,
    required super.updated_at,
    required super.created_at,
    required super.email_verified_at,
    required super.image,
    required super.id,
    required super.email,
    super.passwordConfirmation,
    required super.phone,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      name: json['name'],
      Birth: json['Birth'],
      image: json['image'],
      email_verified_at: json['email_verified_at'].toString(),
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'birth': Birth,
      'email': email,
      'passwordConfirmation': passwordConfirmation,
      'phone': phone,
    };
  }
}
