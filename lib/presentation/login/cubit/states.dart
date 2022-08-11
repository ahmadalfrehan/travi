abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uId;
  final String message;

  LoginSuccessState(this.uId, this.message);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}
