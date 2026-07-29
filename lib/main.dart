import 'package:evently_c19/core/app_provider/app_provider.dart';
import 'package:evently_c19/core/theme/app_theme.dart';
import 'package:evently_c19/l10n/app_localizations.dart';
import 'package:evently_c19/modules/login/login_screen.dart';
import 'package:evently_c19/modules/register/register_screen.dart';
import 'package:evently_c19/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      builder: (context, child) {
        var provider = Provider.of<AppProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: provider.themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          title: 'Flutter Demo',
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
          ],
          locale: provider.locale,
          home: LoginScreen(),
        );
      },
    );
  }
}
