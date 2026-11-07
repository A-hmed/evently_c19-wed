import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/core/widgets/custom_back_btn.dart';
import 'package:evently_c19/core/widgets/custom_btn.dart';
import 'package:evently_c19/core/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String email;

  const ForgetPasswordScreen({super.key, required this.email});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _emailController = TextEditingController(
    text: widget.email,
  );
  bool isLoading = false;
  late ThemeData theme = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: CustomBackBtn()),
        title: Text("Forget Password"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/forget_password.png",
              height: MediaQuery.of(context).size.height * .4,
              color: theme.primaryColorLight,
            ),
            SizedBox(height: 24),
            CustomTextField(
              controller: _emailController,
              hintText: 'Enter your email',
              prefixIcon: Icon(Icons.email, color: AppColors.grayColor),
            ),
            SizedBox(height: 24),
            CustomBtn(
              text: "Reset password",
              isLoading: isLoading,
              onTap: () {
                resetPassword();
              },
            ),
          ],
        ),
      ),
    );
  }

  void resetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter your email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    try {
      isLoading = true;
      setState(() {});
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(
        msg: "Check your email to reset your password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(
        msg: e.message ?? "Something went wrong please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
