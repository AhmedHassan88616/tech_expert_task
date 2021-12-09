import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:tech_experts_task/data/models/register_model.dart';
import 'package:tech_experts_task/shared/endpoints/endpoints.dart';
import 'package:tech_experts_task/shared/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context, {bool listen = true}) =>
      BlocProvider.of(context, listen: listen);

  void userRegister({
    required String name,
    required String email,
    required String password,
    String? address,
    String? dateOfBirth,
  }) {
    final data = {
      "name": name,
      "email": email,
      "password": password,
      "role": 3,
      "address": address,
      "gender": genderRadioValue,
    };
    if (dateOfBirth != null) data["dateOfBirth"] = dateOfBirth;
    print(data);
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: SIGNUP,
      data: data,
    ).then((value) {
      print('data : ${value.data}');
      if (value.data['success'].isNotEmpty) value.data['error'] = null;
      emit(RegisterSuccessState(RegisterModel.fromJson(value.data)));
    }).catchError((error) {
      emit(
        RegisterErrorState(
          error: error,
        ),
      );
    });
  }

  bool isPassword = true;
  IconData visibleIcon = Icons.visibility_outlined;

  changePasswordVisibility() {
    isPassword = !isPassword;
    visibleIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  int? genderRadioValue;

  changeRadioButtonValue(int? value) {
    genderRadioValue = value;
    emit(ChangeRadioButtonValueState());
  }

  DateTime selectedDate = DateTime.now();

  selectDate(BuildContext context) async {
    showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1850),
            lastDate: DateTime.now())
        .then((value) {
      final DateTime? picked = value;
      if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        emit(SelectDateOfBirthState(
            DateFormat('dd-MM-yyyy').format(selectedDate)));
      }
    });
  }
}
