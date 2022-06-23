import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/models/cart_models/cart_models.dart';
import 'package:surebaladi/models/category_model/all_categories_model.dart';
import 'package:surebaladi/models/home_models/home_models.dart';
import 'package:surebaladi/modules/cart_list/cart_list_screen.dart';
import 'package:surebaladi/modules/compare/compare_screen.dart';
import 'package:surebaladi/modules/home/home_screen.dart';
import 'package:surebaladi/modules/wish_list/wish_list_screen.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import '../../shared/constants/const.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialAppState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const WishListScreen(),
    const CompareScreen(),
  ];

  int currentIndex = 0;
  final key = GlobalKey<ScaffoldState>();

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(BottomNavState());
  }

  //  cart

  CartModels? cartModels;

  void getCartData() async {
    emit(LoadingCartState());
    await DioHelper.getData(
            url: 'cart', Token: '$bearer ${CacheHelper.getData(key: token)}')
        .then((value) {
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

  // Home
  HomeModel? homeModel;

  void getHomeProductData() {
    emit(HomeProductLoadingState());
    DioHelper.getData(
      url: 'product/getFeatureProducts?pageNo=0&pageSize=15&sortBy=price',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      if (kDebugMode) {
        print('Home Data ${value.data}');
      }
      emit(HomeProductSuccessState());
    }).catchError((error) {
      emit(HomeProductErrorState(error: error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // category
  AllCategoriesModel? allCategoriesModel;

  void getCategory() {
    emit(GetCategoriesLoadingState());
    DioHelper.getData(url: 'category', query: {
      'pageNo': 0,
      'pageSize': 10,
      'sortBy': 'id',
      'isDeleted': 'false'
    }).then((value) {
      emit(GetCategoriesSuccessState());
      allCategoriesModel = AllCategoriesModel.fromJson(value.data);
      if (kDebugMode) {
        print(value.data);
      }
    }).catchError((error) {
      emit(GetCategoriesErrorState(error: error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // add to cart
  bool isAdded = false;
  String? text;
  Map<String, bool> map = {};

  void increaseAddToCart({required int id}) {
    emit(AddToCartState());
    DioHelper.postData(
            url: 'cart/1',
            data: {"productId": id},
            Token: '$bearer $savedToken')
        .then((value) {
      isAdded = true;
      getCartData();
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

  void decreaseAddToCart({required int id}) {
    print('hi');
    emit(AddToCartState());
    DioHelper.postData(
            url: 'cart/-1',
            data: {"productId": id},
            Token: '$bearer $savedToken')
        .then((value) {
      isAdded = true;
      getCartData();
      if (kDebugMode) {
        print(value.data);
      }
    }).catchError((error) {});
  }

  void removeFromCart() {
    isAdded = false;

    emit(AddToCartState());
  }

  CartItemsModel? isProductInCard(ProductHomeModel productHomeModel) {
    var result = cartModels?.cartItems.where((element) => element.product?.id == productHomeModel.id);
    return result!.isEmpty ? null : result.first;
  }

/**
 * 1,2,3,4
 */
// Cart Screen

}
