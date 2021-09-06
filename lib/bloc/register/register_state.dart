part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {
  final String? msg;
  final UserModel? data;

  RegisterSuccess({this.msg,this.data});
  @override
  List<Object> get props => [msg!,data!];
}
class RegisterFailure extends RegisterState {
  final String? msg;

  RegisterFailure({this.msg});
  @override
  List<Object> get props => [msg!];
}
