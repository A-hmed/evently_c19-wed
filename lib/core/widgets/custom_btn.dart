import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomBtn extends StatelessWidget {
  String text;
  void Function()? onTap;
  bool isLoading;
   CustomBtn({super.key,required this.text , required this.onTap ,this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        width: isLoading ? 130 : 400 ,
        height: 48,
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightPrimaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isLoading? Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1,
            ),
          ),
        ): Center(
          child: Text(text,style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),),
        ),
      ),
    );
  }
}
