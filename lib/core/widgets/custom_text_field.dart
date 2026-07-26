import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  bool isPassword;

  CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final bool isPassword;

  @override
  void initState() {
    super.initState();
    isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 20, color: AppColors.grayColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.grayColor, width: 1),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: isPassword,
    );
  }
}
