import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/widget/custom_toast.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final TextEditingController forgotEmailPasswordController =
      TextEditingController();

  ///forgot password
  bool loader = false;
  forgotPassword() async {
    try {
      loader = true;

      notifyListeners();
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgotEmailPasswordController.text);
      loader = false;

      notifyListeners();
      customToast(message: AppString.sendLinkYourEmail);
      Get.back();
    } catch (e) {
      loader = false;

      notifyListeners();
      customToast(message: AppString.noUserFound);
      print("forgotPassword : $e");
    }
  }
}
