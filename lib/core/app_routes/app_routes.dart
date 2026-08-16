import 'package:evently_c19/model/event_dm.dart';
import 'package:evently_c19/modules/add_event/add_event_screen.dart';
import 'package:evently_c19/modules/edit_event/edit_event_screen.dart';
import 'package:evently_c19/modules/event_details/event_details_screen.dart';
import 'package:evently_c19/modules/login/login_screen.dart';
import 'package:evently_c19/modules/main_layout/main_layout.dart';
import 'package:evently_c19/modules/onboarding/onboarding_screen.dart';
import 'package:evently_c19/modules/register/register_screen.dart';
import 'package:evently_c19/modules/splash/splash_screen.dart';
import 'package:evently_c19/modules/start/screens/start_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route login() =>
      MaterialPageRoute(builder: (context) => LoginScreen());
  static Route startScreen() =>
      MaterialPageRoute(builder: (context) => StartScreen());
  static Route register() =>
      MaterialPageRoute(builder: (context) => RegisterScreen());
  static Route splash() =>
      MaterialPageRoute(builder: (context) => SplashScreen());
  static Route home() =>
      MaterialPageRoute(builder: (context) => MainLayoutScreen());
  static Route addEvent() =>
      MaterialPageRoute(builder: (context) => AddEventScreen());
  static Route onboarding() =>
      MaterialPageRoute(builder: (context) => OnboardingScreen());
  static Route editEvent(EventDM event) =>
      MaterialPageRoute(builder: (context) => EditEventScreen(event: event));
  static Route eventDetails(EventDM event) =>
      MaterialPageRoute(builder: (context) => EventDetailsScreen(event: event));
}
