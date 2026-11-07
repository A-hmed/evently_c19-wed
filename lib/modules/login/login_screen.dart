import 'package:evently_c19/core/app_routes/app_routes.dart';
import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/core/firebase/google_auth_helper.dart';
import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/core/widgets/custom_btn.dart';
import 'package:evently_c19/core/widgets/custom_text_field.dart';
import 'package:evently_c19/core/widgets/google_btn.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, UserCredential;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController(
    text: "ahmed@gmail.com",
  );
  TextEditingController _passwordController = TextEditingController(
    text: "123456",
  );
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
                    'Login to your account',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email, color: AppColors.grayColor),
                  isPassword: false,
                ),
                SizedBox(height: 12),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock, color: AppColors.grayColor),
                  isPassword: true,
                ),
                SizedBox(height: 12),
                Align(
                  alignment: AlignmentGeometry.centerEnd,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        AppRoutes.forgetPassword(_emailController.text),
                      );
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: theme.primaryColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                CustomBtn(
                  text: "Login",
                  isLoading: isLoading,
                  onTap: () {
                    login();
                  },
                ),
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
                        Navigator.push(context, AppRoutes.register());
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
                  text: "Login with Google",
                  isLoading: isGoogleLoading,
                  onTap: () {
                    loginWithGoogle();
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

  void login() async {
    try {
      isLoading = true;
      setState(() {});
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
      UserDM.currentUser = await getUserFromFirestore(credential.user!.uid);
      isLoading = false;
      setState(() {});
      Navigator.push(context, AppRoutes.home());
      Fluttertoast.showToast(
        msg: "Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      setState(() {});

      var message = e.code == 'invalid-credential'
          ? "Incorrect email or password"
          : e.message ?? "Something went wrong please try again later";
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

  void loginWithGoogle() async {
    try {
      isGoogleLoading = true;
      setState(() {});
      UserDM.currentUser = await signInWithGoogle();
      isGoogleLoading = false;
      setState(() {});
      Navigator.pushReplacement(context, AppRoutes.home());
      Fluttertoast.showToast(
        msg: "Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
