import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:project_one_maybe_clean_architecture/data/Models/UserModel.dart';
import 'package:project_one_maybe_clean_architecture/presentation/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var baseUrl = 'https://ahmadalfrehan.000webhostapp.com';

  void userRegister(UserModel user) async {
    final headers = {
      "content-type": "application/json",
    };
    await http
        .post(
      Uri.parse('$baseUrl/api/auth/register'),
      body: json.encode({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'password_confirmation': user.passwordConfirmation,
        'phone': user.phone,
        'Birth': user.Birth,
      }),
      headers: headers,
    )
        .then((value) {
      print(value.body);
      emit(RegisterSuccessState(value.body));
    }).catchError((onError) {
      print(onError);
      emit(RegisterErrorState(onError.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required bool isEmailVerifaed,
  }) async {}

  bool by = false;

  bool changeBool(var c, var y) {
    emit(RegisterChangePasswordVisibilityState());
    c = y;
    return c;
  }
}
