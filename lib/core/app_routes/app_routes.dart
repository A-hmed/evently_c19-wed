import 'package:evently_c19/modules/login/login_screen.dart';
import 'package:evently_c19/modules/register/register_screen.dart';
import 'package:evently_c19/modules/splash/splash_screen.dart';
import 'package:evently_c19/modules/start/screens/start_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route login() => MaterialPageRoute(builder: (context) => LoginScreen());
  static Route startScreen() => MaterialPageRoute(builder: (context) => StartScreen());
  static Route register() => MaterialPageRoute(builder: (context) => RegisterScreen());
  static Route splash() => MaterialPageRoute(builder: (context) => SplashScreen());
}
