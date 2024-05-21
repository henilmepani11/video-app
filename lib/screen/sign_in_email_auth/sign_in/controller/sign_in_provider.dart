import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/services/auth_services.dart';

class SignInProvider extends ChangeNotifier {
  /// SignInTextEditingController
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();

  bool? obscureText = false;
  bool isLoader = false;

  /// signInEmailPassword Function
  Future<void> signInEmailPassword({context}) async {
    try {
      isLoader = true;
      notifyListeners();
      UserCredential? userCredential = await AuthServices.signInEmailPassword(
          signInEmailController.text, signInPasswordController.text);

      if (userCredential?.user != null) {
        Provider.of<AppProvider>(context, listen: false)
            .getUserProfile(userCredential: userCredential);

        Get.offAllNamed(AppRouteString.dashboardScreen);
        Provider.of<AppProvider>(context, listen: false).saveUserLogin();

        if (isCheckedRememberMe == false) {
          signInTextEditingControllerClear();
          pre1?.clear();
          notifyListeners();
        }
        isLoader = false;
        notifyListeners();
      } else {
        isLoader = false;
        signInEmailController.clear();
        signInPasswordController.clear();
        notifyListeners();
      }
    } catch (e) {
      print('signInEmailPassword: $e');
    }
    notifyListeners();
  }

  final auth = FirebaseAuth.instance.currentUser;

  /// remember user email and password
  bool isCheckedRememberMe = false;
  void rememberUserEmailPassword(bool value) async {
    isCheckedRememberMe = value;
    final pref = await SharedPreferences.getInstance();
    pref.setString("email", signInEmailController.text);
    pref.setString("password", signInPasswordController.text);
    pref.setBool("remember", isCheckedRememberMe);
    notifyListeners();
  }

  /// get remember user email and password
  SharedPreferences? pre1;
  void getRememberUserEmailPassword() async {
    final pref = await SharedPreferences.getInstance();
    pre1 = pref;
    String? email = pref.getString("email");
    String? password = pref.getString("password");
    bool? check = pref.getBool("remember");
    if (check == true) {
      signInEmailController.text = email.toString();
      signInPasswordController.text = password.toString();
      isCheckedRememberMe = check ?? false;
    }
    notifyListeners();
  }

  ///sign in textEditing controller clear
  void signInTextEditingControllerClear() {
    signInEmailController.clear();
    signInPasswordController.clear();
  }
}
