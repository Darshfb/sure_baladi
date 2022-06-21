part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class FirstCaseState extends RegisterState {}
class SecondCaseState extends RegisterState {}
class ThirdCaseState extends RegisterState {}
class ForthCaseState extends RegisterState {}

class ChangeVisibilityState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class SuccessRegisterState extends RegisterState {}

class ErrorRegisterState extends RegisterState {
  final String error;

  ErrorRegisterState({required this.error});
}
