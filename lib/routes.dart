import 'package:assessment_idejualan/screens/home_screen.dart';
import 'package:assessment_idejualan/screens/login_screen.dart';
import 'package:assessment_idejualan/screens/register_screen.dart';
import 'package:flutter/material.dart';

MaterialPageRoute _pageRoute({RouteSettings? settings,Widget? child})=>MaterialPageRoute(
  builder: (_) => child!,
  settings: settings
);

Route? onGenerateRoute(RouteSettings settings){
  Route? _route;
  final _args = settings.arguments;
  switch(settings.name){
    case rLogin:
      _route = _pageRoute(child: LoginScreen(),settings: settings);
      break;
    case rRegister:
      _route = _pageRoute(child: RegisterScreen(),settings: settings);
      break;
    case rHome:
      _route = _pageRoute(child: HomeScreen(),settings: settings);
      break;
    default:
      break;
  }
  return _route;
}

const String rLogin = 'routeLogin';
const String rRegister = 'routeRegister';
const String rHome = 'routeHome';