import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_experts_task/presitation/home/home_screen.dart';
import 'package:tech_experts_task/presitation/login/login_screen.dart';
import 'package:tech_experts_task/shared/bloc_observer/bloc_server.dart';
import 'package:tech_experts_task/shared/network/local/cache_helper.dart';
import 'package:tech_experts_task/shared/network/remote/dio_helper.dart';
import 'package:tech_experts_task/shared/styles/colors.dart';
import 'package:tech_experts_task/shared/styles/themes.dart';

import 'bussiness_logic/home_cubit/home_cubit.dart';
import 'bussiness_logic/login_cubit/login_cubit.dart';
import 'bussiness_logic/register_cubit/register_cubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );

   runApp(MyApp());
}

class MyApp extends StatelessWidget {

  String? _token = CacheHelper.getData(key: 'token');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) =>
          LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) =>
              RegisterCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) =>
              HomeCubit()..getHomeData(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: LoginScreen(),
      ),
    );
  }
}

