import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tech_experts_task/data/models/login_model.dart';
import 'package:tech_experts_task/data/repositories/auth_repository.dart';
import 'package:tech_experts_task/shared/endpoints/endpoints.dart';
import 'package:tech_experts_task/shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context, {bool listen = true}) =>
      BlocProvider.of(context, listen: listen);

  final _authenticationRepository = AuthenticationRepository();


  bool isPassword = true;
  IconData visibleIcon = Icons.visibility_outlined;

  changePasswordVisibility() {
    isPassword = !isPassword;
    visibleIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }



  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    _authenticationRepository
        .login(email: email, password: password)
        .then((value) => emit(LoginSuccessState(value)))
        .catchError(
          (error) => emit(
        LoginErrorState(
          error: error,
        ),
      ),
    );
  }



}
