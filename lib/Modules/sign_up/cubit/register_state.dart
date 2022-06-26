
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class ChangeToggleState extends RegisterState {}
class ChooseAdminDescState extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterErrorSSN extends RegisterState {}
class RegisterFailuerState extends RegisterState {
  String errorMsg;
  RegisterFailuerState(this.errorMsg);
}
