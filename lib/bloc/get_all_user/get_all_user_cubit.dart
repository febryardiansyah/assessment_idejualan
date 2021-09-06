import 'package:assessment_idejualan/models/user_model.dart';
import 'package:assessment_idejualan/repositories/user_repo.dart';
import 'package:assessment_idejualan/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_all_user_state.dart';

class GetAllUserCubit extends Cubit<GetAllUserState> {
  GetAllUserCubit() : super(GetAllUserInitial());
  final _repo = UserRepo();

  Future<void> fetchAllUser()async{
    emit(GetAllUserLoading());
    try{
      final _res = await _repo.allUser();
      emit(GetAllUserSuccess(data: _res!.data));
    }catch(e){
      print(e);
      emit(GetAllUserFailure(msg: BaseString.errMsg));
    }
  }
}
