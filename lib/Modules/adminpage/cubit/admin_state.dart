part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}
class GetReportsLoading extends AdminState {}
class GetReportsSuccess extends AdminState {}
class GetUserLoading extends AdminState {}
class GetUserSuccess extends AdminState {}
class Fininsh extends AdminState {}
