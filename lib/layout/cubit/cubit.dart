import 'package:easy_localization/easy_localization.dart';
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
import 'package:surebaladi/modules/home/home_screen.dart';
import 'package:surebaladi/modules/wish_list/wish_list_screen.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import 'package:surebaladi/shared/constants/const.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialAppState());

  static HomeCubit get(context) => BlocProvider.of(context);
  String TOKEN = '$bearer ${CacheHelper.getData(key: token)}';
  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    const CartScreen(),
    // TestCategoryScreen(),
    const WishListScreen(),
  ];

  int currentIndex = 0;
  final key = GlobalKey<ScaffoldState>();

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(BottomNavState());
  }

  //Localization
  bool? localization;

  void changeLanguage(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('en', 'US')) {
      context.setLocale(const Locale('ar', 'EG'));
    } else {
      context.setLocale(const Locale('en', 'US'));
    }
    if (context.locale == const Locale('en', 'US')) {
      localization = true;
    } else {
      localization = false;
    }
    emit(ChangeLanguageState());
  }

  void changeLanguageNew(
      {required bool isEnglish, required BuildContext context}) async {
    if (EasyLocalization.of(context)!.locale == const Locale('en', 'US')) {
      await context.setLocale(const Locale('en'));
    } else {
      await context.setLocale(const Locale('ar'));
    }
    emit(ChangeLanguageState());
  }

  // Home
  HomeModel? homeModel;
  List<dynamic> content = [];
  int page = 0;
  bool? last;
  bool? lang;

  void getHomeProductData(
      {bool isRefresh = true, required BuildContext context}) {
    if (isRefresh) {
      page = 0;
    }
    emit(HomeProductLoadingState());
    DioHelper.getData(
            url:
                'product/getFeatureProducts?pageNo=$page&pageSize=15&sortBy=price',
            lang: isLang ? 'en' : 'ar')
        .then((value) {
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
    DioHelper.getData(
            url: 'category',
            query: {
              'pageNo': 0,
              'pageSize': 10,
              'sortBy': 'id',
              'isDeleted': 'false'
            },
            lang: isLang ? 'en' : 'ar')
        .then((value) {
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
      lang: isLang ? 'en' : 'ar',
    ).then((value) {
      categoryProductModel = CategoryProductModel.fromJson(value.data);
      if (isRefresh) {
        productContent = categoryProductModel!.content;
      } else {
        productContent.addAll(categoryProductModel!.content);
      }
      emit(GetCategoryProductSuccessState());
      productPageNo++;
      lastProduct = value.data['last'];
    }).catchError((error) {
      emit(GetCategoryProductErrorState(error: error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  bool isCategoryAdd = false;

  void getProduct() {
    isCategoryAdd = !isCategoryAdd;
    emit(ChangeCategoryState());
  }

  CartModels? cartModels;
  String? cartSize;

  // String? cartLen;
  void getCartData() {
    emit(LoadingCartState());
    DioHelper.getData(
      url: 'cart',
      Token: TOKEN,
      lang: isLang ? 'en' : 'ar',
    ).then((value) {
      cartModels = CartModels.fromJson(value.data);
      cartSize = cartModels!.cartItems.length.toString();
      emit(SuccessCartState());
    }).catchError((error) {
      emit(ErrorCartState(error: error.toString()));
      if (kDebugMode) {
        print('..................$error');
      }
    });
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

  CartItemsModel? isCategoryProductInCard(
      CategoryProductContentModel categoryProductContentModel) {
    var result = cartModels?.cartItems.where(
        (element) => element.product?.id == categoryProductContentModel.id);
    return result == null
        ? null
        : result.isEmpty
            ? null
            : result.first;
  }

  static bool isLang = CacheHelper.getData(key: 'lang') ?? false;

  void changeLang({required bool language}) {
    isLang = language;
    CacheHelper.saveData(key: 'lang', value: language);
    print('............... lang $isLang');
    emit(ChangeLangState());
  }

  Future<bool> onWillPop({
    required BuildContext context,
  }) async {
    emit(LoadingOnWillPopState());
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.green.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 0,
        title: Text('Are you sure?'.tr()),
        content: Text('Do you want close The app?'.tr()),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'.tr()),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              emit(SuccessOnWillPopState());
            },
            child: Text('Yes'.tr()),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }
}
