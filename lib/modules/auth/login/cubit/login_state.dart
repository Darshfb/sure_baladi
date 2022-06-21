part of 'login_cubit.dart';

@immutable
abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class ChangeVisibilityState extends LoginStates{}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String token;

  LoginSuccessState({required this.token});
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState({required this.error});
}

