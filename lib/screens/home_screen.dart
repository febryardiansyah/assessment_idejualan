import 'package:assessment_idejualan/bloc/get_all_user/get_all_user_cubit.dart';
import 'package:assessment_idejualan/models/user_model.dart';
import 'package:assessment_idejualan/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _box = Hive.box(BaseString.hUser);

  @override
  void initState() {
    super.initState();
    context.read<GetAllUserCubit>().fetchAllUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Home Screen',style: TextStyle(color: Colors.white),),
      ),
      body: BlocBuilder<GetAllUserCubit,GetAllUserState>(
        builder: (context,state){
          if (state is GetAllUserLoading) {
            return Center(child: CupertinoActivityIndicator(),);
          }
          if (state is GetAllUserFailure) {
            return Center(child: Text(state.msg!),);
          }
          if (state is GetAllUserSuccess) {
            final _data = state.data;
            if (_data!.length == 0) {
              return Center(child: Text('Empty'),);
            }
            return ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context,i){
                UserModel _item = _data[i];
                return ListTile(
                  title: Text(_item.name!),
                  subtitle: Text('Click for detail'),
                  trailing: IconButton(icon: Icon(Icons.delete_outline),onPressed: (){
                    _box.deleteAt(i);
                    context.read<GetAllUserCubit>().fetchAllUser();
                  },),
                  onTap: (){
                    showDialog(context: context, builder: (context)=>AlertDialog(
                      content: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(_item.name!),
                          Text(_item.email!),
                          Text(_item.password!),
                          Text(_item.address!),
                          Text(_item.age!),
                        ],
                      ),
                      actions: [
                        FlatButton(onPressed: ()=>Navigator.pop(context), child: Text('Close'))
                      ],
                    ));
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}