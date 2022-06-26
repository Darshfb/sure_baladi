import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/models/cart_models/cart_models.dart';
import 'package:surebaladi/models/category_model/all_categories_model.dart';
import 'package:surebaladi/models/category_model/category_product_model.dart';
import 'package:surebaladi/models/home_models/home_models.dart';
import 'package:surebaladi/modules/cart_list/cart_list_screen.dart';
import 'package:surebaladi/modules/category/category_screen.dart';
import 'package:surebaladi/modules/compare/compare_screen.dart';
import 'package:surebaladi/modules/home/home_screen.dart';
import 'package:surebaladi/modules/wish_list/wish_list_screen.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import 'package:surebaladi/shared/constants/const.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialAppState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
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

  // category products
  int pageNo = 0;
  CategoryProductModel? categoryProductModel;

  void getCategoryProduct({int? id}) {
    emit(GetCategoryProductLoadingState());
    DioHelper.getData(
            url: 'product/category/$id',
            query: {"pageNo": pageNo, "pageSize": 10, "sortBy": "id"},
            Token: '$bearer $savedToken')
        .then((value) {
      categoryProductModel = CategoryProductModel.fromJson(value.data);
      if (kDebugMode) {
        print(value.data);
      }
      emit(GetCategoryProductSuccessState());
    }).catchError((error) {
      emit(GetCategoryProductErrorState(error: error.toString()));
    });
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
        print('cart size is ${cartModels!.cartItems.length}');
      }
    }).catchError((error) {
      emit(ErrorCartState(error: error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  CartItemsModel? isCategoryProductInCard(
      CategoryProductContentModel categoryProductContentModel) {
    var result = cartModels?.cartItems.where(
        (element) => element.product?.id == categoryProductContentModel.id);
    return result!.isEmpty ? null : result.first;
  }

  void addMoreProduct() {
    pageNo++;
    getCategoryProduct();
  }

  // add to cart

  void increaseAddToCart({required int id}) {
    emit(LoadingIncreaseItemToCartState());
    DioHelper.postData(
            url: 'cart/1',
            data: {"productId": id},
            Token: '$bearer $savedToken')
        .then((value) {
      emit(IncreaseItemToCartState());
      getCartData();
    }).catchError((error) {});
  }

  void decreaseAddToCart({required int id}) {
    emit(LoadingDecreaseItemToCartState());
    DioHelper.postData(
            url: 'cart/-1',
            data: {"productId": id},
            Token: '$bearer $savedToken')
        .then((value) {
      emit(DecreaseItemToCartState());
      getCartData();
      if (kDebugMode) {
        print(value.data);
      }
    }).catchError((error) {});
  }

  void removeFromCart({required int id}) {
    DioHelper.deleteData(url: 'cart/$id', Token: '$bearer $savedToken')
        .then((value) {
      print('success');
      getCartData();
    }).catchError((error) {});
    emit(AddToCartState());
  }

  CartItemsModel? isProductInCard(ProductHomeModel productHomeModel) {
    emit(LoadingIsItemInCart());
    var result = cartModels?.cartItems
        .where((element) => element.product?.id == productHomeModel.id);
    emit(IsItemInCart());
    return result!.isEmpty ? null : result.first;
  }

/**
 * 1,2,3,4
 */
// Cart Screen

}
