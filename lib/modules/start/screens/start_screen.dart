import 'package:evently_c19/core/app_provider/app_provider.dart';
import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/core/widgets/custom_btn.dart';
import 'package:evently_c19/modules/start/widgets/selection_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: "logo",
                  child: Image.asset("assets/logo/app_logo.png", width: 140),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: Image.asset(
                  "assets/images/start_image.png",
                  width: 340,
                  color: theme.primaryColorLight,
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Personalize Your Experience",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Text(
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grayColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Language",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightPrimaryColor,
                      ),
                    ),
                  ),

                  SelectionItem(text: "English", isSelected: true),
                  SizedBox(width: 8),
                  SelectionItem(text: "Arabic", isSelected: false),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Theme",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightPrimaryColor,
                      ),
                    ),
                  ),

                  SelectionItem(
                    icon: "assets/icons/icn_light.png",
                    isSelected: provider.themeMode == ThemeMode.light,
                    onTap: () {
                      provider.changeTheme(ThemeMode.light);
                    },
                  ),
                  SizedBox(width: 8),
                  SelectionItem(
                    icon: "assets/icons/icn_dark.png",
                    isSelected: provider.themeMode == ThemeMode.dark,
                  onTap: () {
                    provider.changeTheme(ThemeMode.dark);

                  },
                  ),
                ],
              ),
              Spacer(),
              Center(
                child: CustomBtn(text: "Let’s start", onTap: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
