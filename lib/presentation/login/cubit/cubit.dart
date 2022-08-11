import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:project_one_maybe_clean_architecture/data/Models/UserModel.dart';
import 'package:project_one_maybe_clean_architecture/presentation/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  var baseUrl = 'https://ahmadalfrehan.000webhostapp.com';

  userLogin(UserModel user) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWFkYWxmcmVoYW4uMDAwd2ViaG9zdGFwcC5jb20vYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2NTk3MjY2NzEsImV4cCI6MTY1OTczMDI3MSwibmJmIjoxNjU5NzI2NjcxLCJqdGkiOiJ4UUZOa24wNEZScGhvTFVTIiwic3ViIjoiNSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.s8qsFTW8QKxbwdrxmVwa__EiMLoDViqmKtCO94gZ7fE',
    };
    await http
        .post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: headers,
      body: json.encode({
        'email': user.email,
        'password': user.password,
      }),
    )
        .then((value) {
      print(value.body.toString());
      String t = 'sss';
      Map<dynamic, dynamic> userdata =
          Map<dynamic, dynamic>.from(json.decode(value.body));
      t = userdata['access_token'].toString();
      print(t);
      emit(
        LoginSuccessState(t, value.body),
      );
    }).catchError((onError) {
      emit(
        LoginErrorState(onError.toString()),
      );
    });
  }

  bool ChangeBool(var c, var y) {
    emit(ChangePasswordVisibilityState());
    c = y;
    return c;
  }
}
