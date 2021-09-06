import 'package:assessment_idejualan/bloc/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPassInvisible = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();
  TextEditingController _ageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<RegisterCubit,RegisterState>(
          listener: (context,state){
            if (state is RegisterLoading) {
              EasyLoading.show(status: 'Loading..');
            }
            if (state is RegisterFailure) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.msg!);
            }
            if (state is RegisterSuccess) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess(state.msg!);
            }
          },
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: ()=>Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          SizedBox(width: 5,),
                          Text('Back')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 24.0, right: 24.0),
                      children: <Widget>[
                        Text('Create new account',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                        SizedBox(height: 30.0),
                        TextFormField(
                          controller: _nameCtrl,
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Name',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            print(value);
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
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: _addressCtrl,
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Address',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: _ageCtrl,
                          keyboardType: TextInputType.number,
                          validator: (value){
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Age',
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
                              print(_formKey.currentState!.validate());
                              if (_formKey.currentState!.validate()) {
                                context.read<RegisterCubit>().createUser(
                                  name: _nameCtrl.text,email: _emailCtrl.text,password: _passCtrl.text,
                                  age: _ageCtrl.text,address: _addressCtrl.text
                                );
                              }
                            },
                            padding: EdgeInsets.all(12),
                            color: Colors.lightBlueAccent,
                            child: Text('Register', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}