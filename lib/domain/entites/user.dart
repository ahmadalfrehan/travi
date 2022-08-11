class User {
  int? id;
  String? email_verified_at;
  String? name;
  String? email;
  String? phone;
  String? Birth;
  String? password;
  String? created_at;
  String? updated_at;
  String? image;
  String? passwordConfirmation;

  User({
    required this.name,
    this.password,
    required this.Birth,
    required this.id,
    required this.image,
    required this.email_verified_at,
    required this.created_at,
    required this.updated_at,
    required this.email,
    this.passwordConfirmation,
    required this.phone,
  });
}
