part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}
class SplashInitial extends SplashState {}

class SplashHomeLayoutUserState extends SplashState {}
class SplashHomeLayoutAdminState extends SplashState {
  UserModel userModel;

  SplashHomeLayoutAdminState({required this.userModel});
}
class SplashLoginState extends SplashState {}
