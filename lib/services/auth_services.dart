import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/widget/custom_toast.dart';

class AuthServices {
  ///register EmailPassword
  static Future<UserCredential?> registerEmailPassword(
      String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        customToast(message: AppString.weakPassword);
      } else if (e.code == 'email-already-in-use') {
        customToast(message: AppString.theAccountAlreadyExistsForThatEmail);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// signIn with EmailPassword
  static Future<UserCredential?> signInEmailPassword(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        customToast(message: AppString.noUserFoundForThatEmail);
      } else if (e.code == 'wrong-password') {
        customToast(message: AppString.wrongPassword);
      }
    }
  }
}
