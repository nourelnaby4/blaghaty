part of 'forget_cubit.dart';

@immutable
abstract class ForgetState {}

class ForgetInitial extends ForgetState {}
class ForgetLoading extends ForgetState {}
class ForgetSuccess extends ForgetState {}
