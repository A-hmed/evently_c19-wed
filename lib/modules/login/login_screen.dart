import 'package:evently_c19/core/app_routes/app_routes.dart';
import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/core/widgets/custom_btn.dart';
import 'package:evently_c19/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/app_logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                SizedBox(height: 40),
                Align(
                  alignment: AlignmentGeometry.centerStart,
                  child: Text(
                    'Login to your account',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email, color: AppColors.grayColor),
                  isPassword: false,
                ),
                SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock, color: AppColors.grayColor),
                  isPassword: true,
                ),
                SizedBox(height: 12),
                CustomBtn(text: "Login", onTap: () {}),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          AppRoutes.register(),
                        );
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          color: theme.primaryColor,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
