import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/models/cart_models/checkout_models.dart';
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
  String TOKEN = '$bearer ${CacheHelper.getData(key: token)}';

  AddressModel? addressModel;
  List<dynamic> list = [];
  void getAddress() {
    list = [];
    emit(LoadingGetAddressState());
    DioHelper.getData(
            url: 'Addresses?pageNo=0&pageSize=10&sortBy=id', Token: TOKEN)
        .then((value) {
      list = value.data;
      //addressModel = AddressModel.fromJson(value.data);
      emit(SuccessGetAddressState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  bool isChecked = false;
  int? currentIndex = 0;
  void changeAddress({required int index}) {
    currentIndex = index;
    isChecked = !isChecked;
    emit(ChangeAddressState());
  }

  void createOrder({
    required String id,
    required String date,
  }) {
    emit(LoadingCreateOrderState());
    DioHelper.postData(
        url: 'order',
         Token: TOKEN,
        data: {"addressId": id, "orderDeliveryDate": date}).then((value) {
      print(value.data);
      emit(SuccessCreateOrderState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCreateOrderState(error: error.toString()));
    });
  }

  String? selectedValue;

  void continueButton(context, AlertDialog alertDialog) {
    if (currentStep < 1) {
      currentStep++;
      emit(ContinueState());
    } else {
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

  void onStepTapped({required int index}) {
    currentStep = index;
    emit(OnTappedState());
  }
}
