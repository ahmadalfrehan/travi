import 'package:project_one_maybe_clean_architecture/domain/entites/user.dart';

class HomeTrips {
  User? user;
  List<dynamic>? offered;
  List<dynamic>? recommended;
  List<dynamic>? best;

  HomeTrips({
    required this.user,
    required this.offered,
    required this.recommended,
    required this.best,
  });
}
