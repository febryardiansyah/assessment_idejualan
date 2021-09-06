part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final String? msg;

  LoginSuccess({this.msg});
  @override
  List<Object> get props => [msg!];
}
class LoginFailure extends LoginState {
  final String? msg;

  LoginFailure({this.msg});
  @override
  List<Object> get props => [msg!];
}
