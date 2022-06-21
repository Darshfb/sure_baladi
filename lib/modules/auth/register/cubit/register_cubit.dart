import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import 'package:surebaladi/shared/constants/end_points.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String email,
    required String password,
    required String phoneNumber,
    required String username,
    required String fullName,
  }) {
    emit(LoadingRegisterState());
    DioHelper.postData(url: register, data: {
      "email": email,
      "password": password,
      "username": username,
      "phoneNumber": phoneNumber,
      "fullName": fullName
    }).then((value) {
      emit(SuccessRegisterState());
      print(value.data);
    }).catchError((error) {
      emit(ErrorRegisterState(error: error.toString()));
    });
  }



  bool isObscure = true;
  IconData? visibilityIcon = Icons.visibility_off;

  void registerChangeVisibility() {
    isObscure = !isObscure;
    visibilityIcon = (isObscure) ? Icons.visibility_off : Icons.visibility;
    emit(ChangeVisibilityState());
  }

  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;
  bool hasUpperCaseCharacters = false;
  bool hasSpecialCharacters = false;

  void onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final specialRegex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');
    final upperCaseRegex = RegExp(r'[A-Z]');
    isPasswordEightCharacters = false;
    hasPasswordOneNumber = false;
    hasUpperCaseCharacters = false;
    hasSpecialCharacters = false;
    emit(FirstCaseState());
    if (password.length >= 8) {
      isPasswordEightCharacters = true;
      emit(FirstCaseState());
    }
    if (numericRegex.hasMatch(password)) {
      hasPasswordOneNumber = true;
      emit(SecondCaseState());
    }
    if (upperCaseRegex.hasMatch(password)) {
      hasUpperCaseCharacters = true;
      emit(ThirdCaseState());
    }
    if (specialRegex.hasMatch(password)) {
      hasSpecialCharacters = true;
      emit(ForthCaseState());
    }
  }
}
