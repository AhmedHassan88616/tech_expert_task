import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_experts_task/bussiness_logic/login_cubit/login_cubit.dart';
import 'package:tech_experts_task/presitation/home/home_screen.dart';
import 'package:tech_experts_task/presitation/register/register_screen.dart';
import 'package:tech_experts_task/shared/components/components.dart';
import 'package:tech_experts_task/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var _emailController = TextEditingController();

  var _passwordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginStates>(
      listener: (context, state) {
        //TODO: implement listener
        if (state is LoginErrorState) {
          print('error : ' + state.error.toString());
          if ((state.error as DioError).error is SocketException)
            showToast(
                message: 'No connection to internet',
                state: ToastStates.FAILED);
          else
            showToast(
                message: 'There is unknownError', state: ToastStates.FAILED);
        } else if (state is LoginSuccessState) {
          if (state.loginModel.error == null) {
            print(state.loginModel.accessToken);
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.accessToken,
            ).then((value) => navigateAndFinishTo(
                  context: context,
                  screen: HomeScreen(),
                ));
          } else {
            showToast(
                message: state.loginModel.error!, state: ToastStates.FAILED);
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      controller: _emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'The email field is required.';
                        } else if (!value.contains('@'))
                          return 'The email must be a valid email address.';
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    BlocBuilder<LoginCubit, LoginStates>(
                      buildWhen: (p, c) =>
                          c is LoginChangePasswordVisibilityState,
                      builder: (context, state) {
                        final loginCubit =
                            LoginCubit.get(context, listen: false);
                        return defaultFormField(
                          controller: _passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: loginCubit.visibleIcon,
                          suffixPressed: loginCubit.changePasswordVisibility,
                          isPassword: loginCubit.isPassword,
                          label: 'password',
                          prefix: Icons.lock_outline,
                        );
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    BlocBuilder<LoginCubit, LoginStates>(
                      buildWhen: (p, c) =>
                          c is! LoginChangePasswordVisibilityState,
                      builder: (context, state) {
                        return BuildCondition(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              function: () => _submit(context), text: 'LOGIN'),
                          fallback: (_) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        defaultTextButton(
                          function: () {
                            navigateTo(
                                context: context, screen: RegisterScreen());
                          },
                          text: 'register',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(context) {
    if (!_formKey.currentState!.validate()) return;
    print(_emailController.text);
    print(_passwordController.text);
    LoginCubit.get(context, listen: false).userLogin(
        email: _emailController.text, password: _passwordController.text);
  }
}
