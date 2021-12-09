import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_experts_task/bussiness_logic/register_cubit/register_cubit.dart';
import 'package:tech_experts_task/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var _nameController = TextEditingController();

  var _emailController = TextEditingController();

  var _passwordController = TextEditingController();

  var _addressController = TextEditingController();
  var _birthDateController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          print('error : ' + state.error.toString());
          if (state.error is DioError) if ((state.error as DioError).error
              is SocketException)
            showToast(
                message: 'No connection to internet',
                state: ToastStates.FAILED);
          else
            showToast(
                message: 'There is unknownError', state: ToastStates.FAILED);
        } else if (state is RegisterSuccessState) {
          if (state.registerModel.success.isEmpty) {
            String errorMsg = "";
            if (state.registerModel.error!.email != null)
              errorMsg = state.registerModel.error!.email![0];
            else if (state.registerModel.error!.name != null)
              errorMsg = state.registerModel.error!.name![0];
            else if (state.registerModel.error!.password != null)
              errorMsg = state.registerModel.error!.password![0];
            else
              errorMsg = 'There is unknown error.';
            showToast(message: errorMsg, state: ToastStates.FAILED);
          } else {
            Navigator.of(context).pop();
            showToast(
                message: state.registerModel.success,
                state: ToastStates.SUCCESS);
          }
        }

        if (state is SelectDateOfBirthState)
          _birthDateController.text = state.selectedDate;
      },
      child: Scaffold(
        appBar: AppBar(),
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
                        'Register',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: _nameController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "The name field is required.";
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty)
                            return "The email field is required.";
                          else if (!value.contains('@'))
                            return "The email must be a valid email address.";
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: _passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: RegisterCubit.get(context).visibleIcon,
                        suffixPressed:
                            RegisterCubit.get(context).changePasswordVisibility,
                        validate: (String value) {
                          if (value.isEmpty)
                            return "The password field is required.";
                          else if (value.length < 8)
                            return "The password must be at least 8 characters.";
                        },
                        isPassword: RegisterCubit.get(context).isPassword,
                        label: 'password',
                        prefix: Icons.lock_outline,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: _addressController,
                        type: TextInputType.text,
                        label: 'Address',
                        prefix: Icons.location_city,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      BlocBuilder<RegisterCubit, RegisterStates>(
                        buildWhen: (previous,current)=>current is SelectDateOfBirthState,
                        builder: (context, state) {
                          final registerCubit =
                              RegisterCubit.get(context, listen: false);
                          return defaultFormField(
                            controller: _birthDateController,
                            readOnly: true,
                            type: TextInputType.text,
                            label: 'Date Of Birth',
                            prefix: Icons.date_range,
                            onTap: () {
                              registerCubit.selectDate(context);
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      BlocBuilder<RegisterCubit, RegisterStates>(
                        buildWhen: (previous,current)=>current is ChangeRadioButtonValueState,
                        builder: (context, state) {
                          final registerCubit =
                              RegisterCubit.get(context, listen: false);
                          return FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Text(
                                  'Gender : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: RadioListTile(
                                    value: 0,
                                    groupValue: registerCubit.genderRadioValue,
                                    onChanged: (int? value) {
                                      registerCubit
                                          .changeRadioButtonValue(value);
                                    },
                                    title: Text("male"),
                                    contentPadding: const EdgeInsets.all(0.0),
                                    dense: true,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: RadioListTile(
                                    value: 1,
                                    groupValue: registerCubit.genderRadioValue,
                                    onChanged: (int? value) {
                                      registerCubit
                                          .changeRadioButtonValue(value);
                                    },
                                    title: Text("female"),
                                    contentPadding: const EdgeInsets.all(0.0),
                                    dense: true,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      BlocBuilder<RegisterCubit, RegisterStates>(
                        buildWhen: (previous,current)=>current is RegisteringState,
                        builder: (context, state) {
                          return BuildCondition(
                            condition: state is RegisterLoadingState,
                            builder: (_) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            fallback: (BuildContext context) => defaultButton(
                                function: () => _submit(context),
                                text: 'Register'),
                          );
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You have an account?'),
                          defaultTextButton(
                            function: () {
                              Navigator.of(context).pop();
                            },
                            text: 'login',
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(context) {
    if (!_formKey.currentState!.validate()) return;
    RegisterCubit.get(context, listen: false).userRegister(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      address:
          _addressController.text.isNotEmpty ? _addressController.text : null,
      dateOfBirth: _birthDateController.text.isNotEmpty
          ? _birthDateController.text
          : null,
    );
  }
}
