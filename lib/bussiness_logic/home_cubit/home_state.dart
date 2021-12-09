part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}


class LoadingHomeData extends HomeState {}

class SuccessHomeData extends HomeState {}

class FailedHomeData extends HomeState {
  final error;

  FailedHomeData(this.error);
}