import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GoogleBtn extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool isLoading;

  const GoogleBtn({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.lightPrimaryColor,
                    strokeWidth: 1,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/google.png", width: 24, height: 24),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppColors.lightPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
