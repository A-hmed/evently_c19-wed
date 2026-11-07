import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBackBtn extends StatelessWidget {

  final void Function()? onTap;

  const CustomBackBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 16,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
