import 'package:evently_c19/core/firebase/firestore_helper.dart';
import 'package:evently_c19/model/user_dm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


bool isGoogleSignInInitialized = false;


Future<UserDM> signInWithGoogle() async {
  if (!isGoogleSignInInitialized) {
    await GoogleSignIn.instance.initialize();
    isGoogleSignInInitialized = true;
  }


  GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();


  var googleAuth = googleUser.authentication;
  var googleCredential = GoogleAuthProvider.credential(
    idToken: googleAuth.idToken,
  );
  UserCredential credential = await FirebaseAuth.instance.signInWithCredential(
    googleCredential,
  );


  if (credential.additionalUserInfo?.isNewUser ?? false) {
    var user = UserDM(
      email: credential.user!.email ?? googleUser.email,
      name: credential.user!.displayName ?? googleUser.displayName ?? "",
      id: credential.user!.uid,
    );
    await createUserInFirestore(user);
    return user;
  }
  return await getUserFromFirestore(credential.user!.uid);
}
