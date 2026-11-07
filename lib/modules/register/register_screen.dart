import 'package:evently_c19/core/app_routes/app_routes.dart';
import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/core/firebase/google_auth_helper.dart';
import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/core/widgets/custom_btn.dart';
import 'package:evently_c19/core/widgets/custom_text_field.dart';
import 'package:evently_c19/core/widgets/google_btn.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController(
    text: "ahmed@gmail.com",
  );
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController(
    text: "123456",
  );
  TextEditingController _rePasswordController = TextEditingController();
  bool isLoading = false;
  bool isGoogleLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                  isPassword: false,
                  controller: _nameController,
                ),
                SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email, color: AppColors.grayColor),
                  isPassword: false,
                  controller: _emailController,
                ),
                SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock, color: AppColors.grayColor),
                  isPassword: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Repassword',
                  prefixIcon: Icon(Icons.lock, color: AppColors.grayColor),
                  isPassword: true,
                  controller: _rePasswordController,
                ),
                SizedBox(height: 12),
                CustomBtn(
                  text: "Sign up",
                  onTap: () {
                    register();
                  },
                  isLoading: isLoading,
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
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
                Text(
                  "Or",
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12),
                GoogleBtn(
                  text: "Sign up with Google",
                  isLoading: isGoogleLoading,
                  onTap: () {
                    signUpWithGoogle();
                  },
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    try {
      isLoading = true;
      setState(() {});
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
      UserDM.currentUser =  UserDM(
        email: _emailController.text,
        name: _nameController.text,
        id: credential.user!.uid,
      );
      createUserInFirestore(
        UserDM.currentUser,
      );
      Navigator.push(context, AppRoutes.home());
      isLoading = false;
      setState(() {});
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      setState(() {});
      var message = "Something went wrong please try again later";
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void signUpWithGoogle() async {
    try {
      isGoogleLoading = true;
      setState(() {});
      UserDM.currentUser = await signInWithGoogle();
      isGoogleLoading = false;
      setState(() {});
      Navigator.pushReplacement(context, AppRoutes.home());
    } on GoogleSignInException catch (e) {
      isGoogleLoading = false;
      setState(() {});


      if (e.code == GoogleSignInExceptionCode.canceled) return;
      Fluttertoast.showToast(
        msg: e.description ?? "Something went wrong please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseAuthException catch (e) {
      isGoogleLoading = false;
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
    } catch (e) {
      isGoogleLoading = false;
      setState(() {});
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
