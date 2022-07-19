import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/models/Login_Models/login_models.dart';
import 'package:surebaladi/models/cart_models/cart_models.dart';
import 'package:surebaladi/modules/cart_list/cubit/cart_states.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import 'package:surebaladi/shared/constants/const.dart';

class CheckOutCubit extends Cubit<CheckOutStates> {
  CheckOutCubit() : super(InitialCartState());

  static CheckOutCubit get(context) => BlocProvider.of(context);

  int currentStep = 0;
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final List<String> items = [
    'تتا مركز منوف المنوفية',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  void continueButton(context, AlertDialog alertDialog) {
    if (currentStep < 2) {
      currentStep++;
      emit(ContinueState());
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        },
      );
    }
  }

  void cancelButton() {
    if (currentStep > 0) {
      currentStep--;
    } else {
      currentStep = 0;
    }
    emit(CancelState());
  }

  void onChangeValue({required String value}) {
    selectedValue = value;
    emit(OnChangeState());
  }
  void onStepTapped({required int index}){
    currentStep = index;
    emit(OnTappedState());
  }
}
