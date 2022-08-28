abstract class CheckOutStates {}

class InitialCartState extends CheckOutStates {}

class ContinueState extends CheckOutStates {}

class CancelState extends CheckOutStates {}

class OnChangeState extends CheckOutStates {}

class OnTappedState extends CheckOutStates {}

class SuccessGetAddressState extends CheckOutStates {}

class LoadingGetAddressState extends CheckOutStates {}

class ChangeAddressState extends CheckOutStates {}

class LoadingCreateOrderState extends CheckOutStates {}

class SuccessCreateOrderState extends CheckOutStates {}

class ErrorCreateOrderState extends CheckOutStates {
  final String error;

  ErrorCreateOrderState({required this.error});
}

class SuccessRemoveAddressState extends CheckOutStates {}

class LoadingRemoveAddressState extends CheckOutStates {}

class ErrorRemoveAddressState extends CheckOutStates {
  final String error;

  ErrorRemoveAddressState({required this.error});
}

class LoadingGetCityState extends CheckOutStates {}

class SuccessGetCityState extends CheckOutStates {}

class ErrorGetCityState extends CheckOutStates {
  final String error;

  ErrorGetCityState({required this.error});
}

class LoadingGetDistrictState extends CheckOutStates {}

class ErrorGetDistrictState extends CheckOutStates {
  final String error;

  ErrorGetDistrictState({required this.error});
}
class SuccessGetDistrictState extends CheckOutStates {}

class CreateErrorNewAddress extends CheckOutStates{
  final String error;

  CreateErrorNewAddress({required this.error});
}
class CreateLoadingNewAddress extends CheckOutStates{}
