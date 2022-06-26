part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class ChangeBottomNavIndexState extends MainState {}
class ChangeIndicatorIndexState extends MainState {}


class ReportChooseListItem extends MainState {}
class ChosseImageSuccesState extends MainState {}
class LocationPerrmisionDeniedState extends MainState {}
class LocationPerrmisionAcceptedState extends MainState {}
class UploadImageSuccess extends MainState {}
class SendNotiFaild extends MainState {}
class UploadReportImageLoading extends MainState {}



class GetHistortSuccess extends MainState {}
class GetHistortLoading extends MainState {}
class SignOutSuccess extends MainState {}


class LoadingUserInfoMainState extends MainState {}
class GetUserInfoSuccessMainState extends MainState {}



