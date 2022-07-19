abstract class CheckOutStates {}

class InitialCartState extends CheckOutStates {}

class ContinueState extends CheckOutStates{}
class CancelState extends CheckOutStates{}
class OnChangeState extends CheckOutStates{}
class OnTappedState extends CheckOutStates{}