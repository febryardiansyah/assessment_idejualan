import 'package:assessment_idejualan/bloc/login/login_cubit.dart';
import 'package:assessment_idejualan/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isPassInvisible = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginCubit,LoginState>(
        listener: (context,state){
          if (state is LoginLoading) {
            EasyLoading.show(status: 'Loading..');
          }
          if (state is LoginFailure) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.msg!);
          }
          if (state is LoginSuccess) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess(state.msg!);
            Navigator.popAndPushNamed(context, rHome);
          }
        },
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.network('https://idejualan.com/wp-content/uploads/2020/07/Logo-Horizontal.png'),
                ),
                SizedBox(height: 48.0),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Field must not be empty';
                    }
                    if (!value.contains('@')) {
                      return 'Email is not valid';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _isPassInvisible,
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Field must not be empty';
                    }
                    if (value.length < 6) {
                      return 'Password length less than 6';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_isPassInvisible?Icons.lock_outline:Icons.lock_open_outlined),
                      onPressed: ()=>setState((){
                        _isPassInvisible = !_isPassInvisible;
                      }),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, rHome);
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                          email: _emailCtrl.text,password: _passCtrl.text
                        );
                      }
                    },
                    padding: EdgeInsets.all(12),
                    color: Colors.lightBlueAccent,
                    child: Text('Log In', style: TextStyle(color: Colors.white)),
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Dont't have an account? Register",
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, rRegister);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
