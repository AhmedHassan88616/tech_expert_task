import 'package:dio/dio.dart';
import 'package:tech_experts_task/data/models/home_model.dart';
import 'package:tech_experts_task/data/models/login_model.dart';
import 'package:tech_experts_task/data/models/register_model.dart';
import 'package:tech_experts_task/shared/endpoints/endpoints.dart';
import 'package:tech_experts_task/shared/network/remote/dio_helper.dart';

class AuthenticationRepository {
  static final AuthenticationRepository _singleton =
      AuthenticationRepository._internal();

  factory AuthenticationRepository() {
    return _singleton;
  }

  AuthenticationRepository._internal();

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await DioHelper.postData(
        url: LOGIN, data: {'email': email, 'password': password});
    print('statusCode: ${response.statusCode}');
    return LoginModel.fromJson(response.data);
  }

  Future<RegisterModel> register({
    required String name,
    required String email,
    required String password,
    String? address,
    String? dateOfBirth,
    int? genderRadioValue,
  }) async {
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
    final response = await DioHelper.postData(
      url: SIGNUP,
      data: data,
    );
    print('response data : ${response.data}');
    if (response.data['success'].isNotEmpty) response.data['error'] = null;
    return RegisterModel.fromJson(response.data);
  }

  Future<HomeModel> getHomeData() async {
    final response = await DioHelper.getData(
      url: '$LOADROLES/1',
    );
    return HomeModel.fromJson(response.data);
  }
}
