import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/models/cart_models/checkout_models.dart';
import 'package:surebaladi/modules/cart_list/cubit/cart_states.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import 'package:surebaladi/shared/component/component.dart';
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
      url: 'Addresses?pageNo=0&pageSize=10&sortBy=id',
      Token: TOKEN,
      lang: HomeCubit.isLang ? 'en' : 'ar',
    ).then((value) {
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
        lang: HomeCubit.isLang ? 'en' : 'ar',
        data: {"addressId": id, "orderDeliveryDate": date}).then((value) {
      print(HomeCubit.isLang);
      emit(SuccessCreateOrderState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
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

  void removeAddress({required int addressId}) {
    emit(LoadingRemoveAddressState());
    DioHelper.deleteData(
      url: 'Addresses/$addressId',
      Token: TOKEN,
      lang: HomeCubit.isLang ? 'en' : 'ar',
    ).then((value) {
      print(value.data);
      getAddress();
    }).catchError((error) {
      emit(ErrorRemoveAddressState(error: error.toString()));
    });
  }

  // CityModel? cityModel;
  List<dynamic> cityModel = [];

  void getAllCity() {
    emit(LoadingGetCityState());
    DioHelper.getData(
      url: 'city',
      Token: TOKEN,
      lang: HomeCubit.isLang ? 'en' : 'ar',
    ).then((value) {
      cityModel = value.data;
      emit(SuccessGetCityState());
    }).catchError((error) {
      emit(ErrorGetCityState(error: error.toString()));
    });
  }

  List<dynamic> district = [];

  void getAllDistrict({required int cityId}) {
    emit(LoadingGetDistrictState());
    DioHelper.getData(
      url: 'district/city/$cityId',
      Token: TOKEN,
      lang: HomeCubit.isLang ? 'en' : 'ar',
    ).then((value) {
      district = value.data;
      emit(SuccessGetDistrictState());
    }).catchError((error) {
      emit(ErrorGetDistrictState(error: error.toString()));
      print(error.toString());
    });
  }

  void addNewAddress({
    required String id,
    required String street,
    required Widget widget,
    required BuildContext context,
  }) {
    emit(CreateLoadingNewAddress());
    DioHelper.postData(
      url: 'Addresses',
      data: {
        "districtId": id,
        "street": street,
      },
      Token: TOKEN,
      lang: HomeCubit.isLang ? 'en' : 'ar',
    ).then((value) {
      navigateAndFinish(context: context, widget: widget);
      getAddress();
    }).catchError((error) {
      CreateErrorNewAddress(error: error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
