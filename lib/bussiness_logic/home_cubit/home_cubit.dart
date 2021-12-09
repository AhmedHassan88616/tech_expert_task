import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tech_experts_task/data/models/home_model.dart';
import 'package:tech_experts_task/shared/endpoints/endpoints.dart';
import 'package:tech_experts_task/shared/network/remote/dio_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context,{bool listen=true}) => BlocProvider.of(context,listen: listen);

  HomeModel? homeModel;
  void getHomeData() {
    emit(LoadingHomeData());
    DioHelper.getData(
      url: '$LOADROLES/1',
    ).then((value) {
      emit(SuccessHomeData());
      homeModel = HomeModel.fromJson(value.data);
    }).catchError((error) {
      print(error);
      emit(FailedHomeData(error));
    });
  }


}
