part of 'register_cubit.dart';

@immutable
abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisteringState extends RegisterStates{}

class RegisterLoadingState extends RegisteringState {}

class RegisterSuccessState extends RegisteringState {
  final RegisterModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisteringState {
  final  error;

  RegisterErrorState({
    required this.error,
  });
}


class RegisterChangePasswordVisibilityState extends RegisterStates {}

class ChangeRadioButtonValueState extends RegisterStates {}

class SelectDateOfBirthState extends RegisterStates {
  final String selectedDate;

  SelectDateOfBirthState(this.selectedDate);
}


