import 'package:assessment_idejualan/repositories/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _repo = UserRepo();

  Future<void> login({String? email,String? password})async{
    emit(LoginLoading());
    try{
      final _res = await _repo.login(email: email,password: password);
      if (_res!.status!) {
        emit(LoginSuccess(msg: _res.msg));
      } else{
        emit(LoginFailure(msg: _res.msg));
      }
    }catch(e){
      print('login err ==== $e');
      emit(LoginFailure(msg: BaseString.errMsg));
    }
  }
}
