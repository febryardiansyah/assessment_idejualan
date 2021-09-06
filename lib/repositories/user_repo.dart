import 'package:assessment_idejualan/models/response_model.dart';
import 'package:assessment_idejualan/models/user_model.dart';
import 'package:assessment_idejualan/utils.dart';
import 'package:hive/hive.dart';

class UserRepo {
  Future<ResponseModel?> register({String? name,String? email,String? password,String? address,String? age})async{
    Future.delayed(Duration(seconds: 2));
    final _box = Hive.box(BaseString.hUser);
    bool _isUserExist = false;
    for(int i = 0;i<_box.length;i++){
      UserModel _item = _box.getAt(i);
      if (_item.email == email) {
        _isUserExist = true;
        break;
      }
    }
    if (_isUserExist) {
      return ResponseModel(msg: 'Email already used',status: false,data: null);
    }
    final _user = UserModel(
        name: name,password: password,email: email,address: address,age: age
    );
    await _box.add(_user);

    return ResponseModel(status: true,msg: 'Register Success',data: _user);
  }

  Future<ResponseModel?> login({String? email,String? password})async{
    Future.delayed(Duration(seconds: 2));
    final _box = Hive.box(BaseString.hUser);
    bool _isEmailExist = false;
    bool _isPassExist = false;
    for(int i = 0;i<_box.length;i++){
      UserModel _item = _box.getAt(i);
      print('db email ${_item.email} === input $email');
      _isEmailExist = _item.email == email;
      _isPassExist = _item.password == password;
      if (_isEmailExist && _isPassExist) {
        break;
      }
    }
    print('$_isEmailExist == $_isPassExist');
    if (!_isEmailExist || !_isPassExist) {
      return ResponseModel(status: false,msg: 'User not exist',data: null);
    }else{
      return ResponseModel(status: true,msg: 'Login success',data: null);
    }
  }

  Future<ResponseModel?> allUser()async{
    final _box = Hive.box(BaseString.hUser);
    return ResponseModel(msg: 'success',status: true,data: _box.values.toList());
  }

}