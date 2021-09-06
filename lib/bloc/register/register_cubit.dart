import 'package:assessment_idejualan/models/user_model.dart';
import 'package:assessment_idejualan/repositories/user_repo.dart';
import 'package:assessment_idejualan/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final _repo = UserRepo();

  Future<void> createUser({String? name,String? email,String? password,String? address,String? age})async{
    emit(RegisterLoading());
    try{
      final _res = await _repo.register(name: name,password: password,email: email,address: address,age: age);
      if (_res!.status!) {
        emit(RegisterSuccess(msg: _res.msg,data: _res.data));
      } else{
        emit(RegisterFailure(msg: _res.msg));
      }
    }catch(e){
      print(e);
      emit(RegisterFailure(msg: BaseString.errMsg));
    }
  }
}
