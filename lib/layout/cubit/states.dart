abstract class HomeStates {}

class InitialAppState extends HomeStates {}

class BottomNavState extends HomeStates {}

class HomeProductLoadingState extends HomeStates {}

class HomeProductSuccessState extends HomeStates {}

class HomeProductErrorState extends HomeStates {
  final String error;

  HomeProductErrorState({required this.error});
}

class AddToCartState extends HomeStates{}


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