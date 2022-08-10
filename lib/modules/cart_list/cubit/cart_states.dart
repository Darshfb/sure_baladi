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
