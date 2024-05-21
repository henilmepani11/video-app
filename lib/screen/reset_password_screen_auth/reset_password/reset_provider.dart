import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_app/widget/custom_toast.dart';

class ResetProvider extends ChangeNotifier {
  ///resetPasswordScreenTextEditingController
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newReSetPasswordController =
      TextEditingController();
  final TextEditingController reSetReEnterNewPasswordController =
      TextEditingController();

  bool isLoader = false;
  bool? currentObscureText = false;
  bool? newPasswordObscureText = false;
  bool? reNewPasswordObscureText = false;

  /// resetPasswordScreenTextEditingControllerClear all clear
  void resetPasswordScreenTextEditingControllerClear() {
    currentPasswordController.clear();
    reSetReEnterNewPasswordController.clear();
    newReSetPasswordController.clear();
    currentObscureText = false;
    newPasswordObscureText = false;
    reNewPasswordObscureText = false;
  }

  /// changeEmailPassword Function
  void changeEmailPassword() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      isLoader = true;

      notifyListeners();
      final cred = EmailAuthProvider.credential(
          email: user!.email!, password: currentPasswordController.text);

      await user.reauthenticateWithCredential(cred).then((value) async {
        await user
            .updatePassword(newReSetPasswordController.text)
            .then((_) {})
            .catchError((error) {
          customToast(message: 'current password not correct');
          isLoader = false;

          notifyListeners();
        });
        if (currentPasswordController.text == newReSetPasswordController.text) {
          isLoader = false;
          customToast(message: 'New Password not should be old password');
        } else {
          customToast(message: 'Reset Password Successfully');
          Get.back();
        }
      });
      isLoader = false;

      notifyListeners();
    } catch (e) {
      customToast(message: 'current password not correct');
      isLoader = false;
    }

    notifyListeners();
  }
}
