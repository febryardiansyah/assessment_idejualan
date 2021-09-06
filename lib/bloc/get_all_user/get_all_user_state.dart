part of 'get_all_user_cubit.dart';

abstract class GetAllUserState extends Equatable {
  const GetAllUserState();
  @override
  List<Object> get props => [];
}

class GetAllUserInitial extends GetAllUserState {}
class GetAllUserLoading extends GetAllUserState {}
class GetAllUserSuccess extends GetAllUserState {
  final List<dynamic>? data;

  GetAllUserSuccess({this.data});
  @override
  List<Object> get props => [data!];
}
class GetAllUserFailure extends GetAllUserState {
  final String? msg;

  GetAllUserFailure({this.msg});
  @override
  List<Object> get props => [msg!];
}
