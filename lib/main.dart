import 'package:assessment_idejualan/bloc/get_all_user/get_all_user_cubit.dart';
import 'package:assessment_idejualan/bloc/login/login_cubit.dart';
import 'package:assessment_idejualan/bloc/register/register_cubit.dart';
import 'package:assessment_idejualan/models/user_model.dart';
import 'package:assessment_idejualan/routes.dart';
import 'package:assessment_idejualan/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pt;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final _dir = await pt.getApplicationDocumentsDirectory();
  Hive.init(_dir.path);
  Hive.openBox(BaseString.hUser);
  Hive.registerAdapter(UserModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>RegisterCubit()),
        BlocProvider(create: (_)=>LoginCubit()),
        BlocProvider(create: (_)=>GetAllUserCubit()),
      ],
      child: MaterialApp(
        builder: EasyLoading.init(),
        title: 'Assessment IdeJualan',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        initialRoute: rLogin,
      ),
    );
  }
}
