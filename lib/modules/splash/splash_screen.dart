import 'package:animate_do/animate_do.dart';
import 'package:evently_c19/core/app_routes/app_routes.dart';
import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ZoomIn(
                duration: Duration(seconds: 2),
                child: Center(
                  child: Hero(
                    tag: "logo",
                    child: Image.asset("assets/logo/app_logo.png", width: 309),
                  ),
                ),
              ),
            ),

            FadeInUp(
              onFinish: (direction) {
                Future.delayed(Duration(seconds: 1), () async {
                  if (FirebaseAuth.instance.currentUser != null) {
                    UserDM.currentUser = await getUserFromFirestore(
                      FirebaseAuth.instance.currentUser!.uid,
                    );
                    Navigator.pushReplacement(context, AppRoutes.home());
                  } else {
                    Navigator.pushReplacement(context, AppRoutes.startScreen());
                  }
                });
              },
              delay: Duration(seconds: 2),
              child: Image.asset("assets/logo/route_logo.png", width: 214),
            ),
          ],
        ),
      ),
    );
  }
}
