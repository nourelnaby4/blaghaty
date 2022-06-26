part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class LoadingUserInfoState extends ProfileState {}
class GetUserInfoSuccessProfileState extends ProfileState {}
class ChangeUserProfileImage extends ProfileState {}
class ChangePasswordProfileState extends ProfileState {}
class ChangePasswordSucces extends ProfileState {}
class UpdateUserInfo extends ProfileState {}
class PhoneNumberSubmited extends ProfileState {}
class ErrorOccurred extends ProfileState {
  String errorMsg;

  ErrorOccurred({required this.errorMsg});
}
