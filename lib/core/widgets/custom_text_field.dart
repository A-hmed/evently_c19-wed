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
  late bool isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    );
    return TextField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 20, color: AppColors.grayColor),
        border:border ,
        enabledBorder: border,
        errorBorder: border,
        focusedBorder: border,
        prefixIcon: widget.prefixIcon,
        suffixIcon:
            widget.suffixIcon ??
            (widget.isPassword
                ? IconButton(
                    onPressed: () {
                      isVisible = !isVisible;
                      setState(() {});
                    },
                    icon: Icon(isVisible ? Icons.remove_red_eye: Icons.visibility_off),
                  )
                : null),
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: isVisible,
    );
  }
}
