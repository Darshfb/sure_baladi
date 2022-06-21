abstract class CartStates {}

class InitialCartState extends CartStates {}

class LoadingCartState extends CartStates {}

class SuccessCartState extends CartStates {}

class ErrorCartState extends CartStates {
  final String error;

  ErrorCartState({required this.error});
}

class AddToCartState extends CartStates {}

