abstract class HomeStates {}

class InitialAppState extends HomeStates {}

class BottomNavState extends HomeStates {}

class HomeProductLoadingState extends HomeStates {}

class HomeProductSuccessState extends HomeStates {}

class HomeProductErrorState extends HomeStates {
  final String error;

  HomeProductErrorState({required this.error});
}

class AddToCartState extends HomeStates {}

class RemoveFromCartState extends HomeStates {}

class LoadingIncreaseItemToCartState extends HomeStates {}

class SuccessIncreaseItemToCartState extends HomeStates {}

class IncreaseItemToCartState extends HomeStates {}

class DecreaseItemToCartState extends HomeStates {}

class LoadingDecreaseItemToCartState extends HomeStates {}

class GetCategoriesLoadingState extends HomeStates {}

class GetCategoriesSuccessState extends HomeStates {}

class GetCategoriesErrorState extends HomeStates {
  final String error;

  GetCategoriesErrorState({required this.error});
}

class LoadingCartState extends HomeStates {}

class SuccessCartState extends HomeStates {}

class ErrorCartState extends HomeStates {
  final String error;

  ErrorCartState({required this.error});
}

class IncreaseCartState extends HomeStates {}

class IsItemInCart extends HomeStates {}

class LoadingIsItemInCart extends HomeStates {}

class DecreaseCartState extends HomeStates {}

class GetCategoryProductLoadingState extends HomeStates {}

class GetCategoryProductSuccessState extends HomeStates {}

class GetCategoryProductErrorState extends HomeStates {
  final String error;

  GetCategoryProductErrorState({required this.error});
}

class GetMoreHomeData extends HomeStates {}

class ChangeLanguageState extends HomeStates {}

class ChangeLangState extends HomeStates {}

class ChangeCategoryState extends HomeStates {}

class LoadingOnWillPopState extends HomeStates{}
class SuccessOnWillPopState extends HomeStates{}
// class onWillPopState extends HomeStates{}