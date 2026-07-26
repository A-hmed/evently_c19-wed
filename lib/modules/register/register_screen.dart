import 'package:evently_c19/core/app_provider/app_provider.dart';
import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<AppProvider>(context);

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
                    'Create your account',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person, color: AppColors.grayColor),
                  suffixIcon: InkWell(
                    onTap: () {
                      provider.togglePassword();
                    },
                    child: Icon(
                      provider.isPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.grayColor,
                    ),
                  ),
                  isPassword: provider.isPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
