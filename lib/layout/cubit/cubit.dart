import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/layout/test_category/category_screen.dart';
import 'package:surebaladi/models/cart_models/cart_models.dart';
import 'package:surebaladi/models/category_model/all_categories_model.dart';
import 'package:surebaladi/models/category_model/category_product_model.dart';
import 'package:surebaladi/models/home_models/home_models.dart';
import 'package:surebaladi/modules/cart_list/cart_list_screen.dart';
import 'package:surebaladi/modules/category/category_screen.dart';
import 'package:surebaladi/modules/home/home_screen.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import 'package:surebaladi/shared/constants/const.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialAppState());

  static HomeCubit get(context) => BlocProvider.of(context);
  String TOKEN = '$bearer ${CacheHelper.getData(key: token)}';
  List<Widget> screens = [
    HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
     TestCategoryScreen(),
    // const WishListScreen(),
  ];

  int currentIndex = 0;
  final key = GlobalKey<ScaffoldState>();

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(BottomNavState());
  }

  // Home
  HomeModel? homeModel;
  List<dynamic> content = [];
  int page = 0;
  bool? last;

  void getHomeProductData({bool isRefresh = true}) {
    if (isRefresh) {
      page = 0;
    }
    emit(HomeProductLoadingState());
    DioHelper.getData(
      url: 'product/getFeatureProducts?pageNo=$page&pageSize=15&sortBy=price',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      if (isRefresh) {
        content = homeModel!.content;
      } else {
        content.addAll(homeModel!.content);
      }
      page++;
      last = homeModel!.last;
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
  int productPageNo = 0;
  CategoryProductModel? categoryProductModel;
  bool? lastProduct;
  List<dynamic> productContent = [];

  void getCategoryProduct({int? id, bool isRefresh = true}) {
    getCartData();
    emit(GetCategoryProductLoadingState());
    DioHelper.getData(
            url: 'product/category/$id',
            query: {"pageNo": productPageNo, "pageSize": 10, "sortBy": "id"},
            Token: TOKEN)
        .then((value) {
      if (value.statusCode == 200) {
        print('......................................');
        print('This is Status code ${value.statusCode}');
        print('......................................');
      }
      categoryProductModel = CategoryProductModel.fromJson(value.data);
      if (isRefresh) {
        productContent = categoryProductModel!.content;
      } else {
        productContent.addAll(categoryProductModel!.content);
      }
      emit(GetCategoryProductSuccessState());
      productPageNo++;
      lastProduct = value.data['last'];

      if (kDebugMode) {
        print('.....');
        print(value.data['last'].toString());
        print('.....');
      }
    }).catchError((error) {
      emit(GetCategoryProductErrorState(error: error.toString()));
      print(error.toString());
    });
  }

  bool isCategoryAdd = false;

  void getProduct(){

    isCategoryAdd = ! isCategoryAdd;
    print(isCategoryAdd);
    emit(ChangeCategoryState());
  }
  Widget? mainWidget;
  void changeWidget({Widget? firstWidget, Widget? secondWidget,}){
    // if(isCategoryAdd){
    //   isCategoryAdd = !isCategoryAdd;
    //   mainWidget = firstWidget;
    // }else{
    //   isCategoryAdd = !isCategoryAdd;
    //   mainWidget = secondWidget;
    // }
  }
  //  cart

  CartModels? cartModels;
  String? cartSize;
  // String? cartLen;
  void getCartData() {
    emit(LoadingCartState());
    DioHelper.getData(url: 'cart', Token: TOKEN).then((value) {
      cartModels = CartModels.fromJson(value.data);
      cartSize = cartModels!.cartItems.length.toString();
      // cartLen = value.data['cartItems'].length.toString();
      if (kDebugMode) {
        print('cart Screen is ${value.data}');
        print('cart size is ${cartModels!.cartItems.length}');
      }
      emit(SuccessCartState());
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

  // add to cart
  void increaseAddToCart({required int id}) {
    emit(LoadingIncreaseItemToCartState());
    DioHelper.postData(url: 'cart/1', data: {"productId": id}, Token: TOKEN)
        .then((value) {
      // emit(SuccessIncreaseItemToCartState());
      getCartData();
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void decreaseAddToCart({required int id}) {
    emit(LoadingDecreaseItemToCartState());
    DioHelper.postData(url: 'cart/-1', data: {"productId": id}, Token: TOKEN)
        .then((value) {
      getCartData();
    }).catchError((error) {});
  }

  void removeFromCart({required int id}) {
    DioHelper.deleteData(url: 'cart/$id', Token: TOKEN).then((value) {
      getCartData();
    }).catchError((error) {});
  }

  CartItemsModel? isProductInCard(ProductHomeModel productHomeModel) {
    emit(LoadingIsItemInCart());
    var result = cartModels?.cartItems
        .where((element) => element.product?.id == productHomeModel.id);
    emit(IsItemInCart());
    return result == null
        ? null
        : result.isEmpty
            ? null
            : result.first;
  }


  //Localization
  void changeLanguage(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('en', 'US')) {
      context.setLocale(const Locale('ar', 'EG'));
    } else {
      context.setLocale(const Locale('en', 'US'));
    }
    emit(ChangeLanguageState());
  }
  bool isLang = false;
  void changeLang({required BuildContext context}){
    isLang = !isLang;
    print(isLang.toString());
    changeLanguage(context);
    // emit(ChangeLangState());
  }
}
