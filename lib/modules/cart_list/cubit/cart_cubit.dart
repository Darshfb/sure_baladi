import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/models/Login_Models/login_models.dart';
import 'package:surebaladi/models/cart_models/cart_models.dart';
import 'package:surebaladi/modules/cart_list/cubit/cart_states.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import 'package:surebaladi/shared/constants/const.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(InitialCartState());

  static CartCubit get(context) => BlocProvider.of(context);

  // void getCartData() {
  //   emit(GetCartDataLoadingState());
  //   DioHelper.getData(
  //     url: 'cart',
  //     Token: '$bearer $savedToken',
  //   ).then((value) {
  //     emit(GetCartDataSuccessState());
  //     cartModels = CartModels.fromJson(value.data);
  //     if (kDebugMode) {
  //       print('cart Screen is ${value.data}');
  //     }
  //   }).catchError((error) {
  //     emit(GetCartDataErrorState(error: error.toString()));
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   });
  // }

  //${context.watch<CartCubit>().cartModels != null ? context.watch<CartCubit>().cartModels!.cartItems.length : ''}'
  CartModels? cartModels;

  void getCartData() async{
    emit(LoadingCartState());
    await DioHelper.getData(url: 'cart',
        Token: '$bearer ${CacheHelper.getData(key: token)}').then((value) {
      emit(SuccessCartState());
      cartModels = CartModels.fromJson(value.data);
      if (kDebugMode) {
        print('cart Screen is ${value.data}');
      }
    }).catchError((error) {
      emit(ErrorCartState(error: error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // add to cart
  bool isAdded = false;
  String? text;
  Map<String, bool> map = {};

  void increaseAddToCart() {
    isAdded = !isAdded;
    emit(AddToCartState());
    DioHelper.postData(
        url: 'cart/1',
        data: {"productId": 34},
        Token: '$bearer $savedToken')
        .then((value) {
      // for (var element in cartModels!.cartItems) {
      // print(element.product!.id.toString());
      // for (var i in homeModel!.content) {
      // print(i.id.toString());
      // if (element.product!.id == i.id) {
      //   text = element.quantity.toString();
      //   print(text);
      // }
      // }
      // }

      // print(value.data);
    }).catchError((error) {});
  }
}
