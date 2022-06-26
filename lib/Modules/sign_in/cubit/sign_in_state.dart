
import '../../../models/user_model.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}
class ChangePasswordState extends SignInState {}


class SignInLoadingState extends SignInState {}
class SignInSuccessStateUserMainLayout extends SignInState {}
class ChangeToggleState extends SignInState {}
class SignInSuccessStateAdminMainLayout extends SignInState {
  UserModel userModel;
  SignInSuccessStateAdminMainLayout({required this.userModel});
}
class SignInFailuerState extends SignInState {
  String error;
  SignInFailuerState(this.error);
}
