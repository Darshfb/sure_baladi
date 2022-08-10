import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/models/Login_Models/login_models.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import 'package:surebaladi/shared/constants/const.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  IconData suffixIcon = Icons.visibility_off_outlined;
  bool secureText = true;

  void changeVisibility() {
    secureText = !secureText;
    suffixIcon = secureText ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ChangeVisibilityState());
  }

  LoginModels? loginModels;
//http://badawy.dscloud.me:8080/api/auth/signin
  void userLogin({
    required String userName,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: 'auth/signin',
        data: {"password": password, "username": userName}).then((value) {
      if (kDebugMode) {
        print(value.data);
      }
      loginModels = LoginModels.fromJson(value.data);
     CacheHelper.saveData(key: 'userName', value: loginModels!.username);
     CacheHelper.saveData(key: 'email', value: loginModels!.email);
      emit(LoginSuccessState(token: loginModels!.token.toString()));
    }).catchError((error) {
      emit(LoginErrorState(error: error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
