import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/sign_up_auth/sign_up/model/sign_up_model.dart';
import 'package:video_app/services/auth_services.dart';

class SignUpProvider extends ChangeNotifier {
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpFullNameController =
      TextEditingController();
  final TextEditingController signUpReEnterPasswordController =
      TextEditingController();
  final TextEditingController signUpSecurityQuestionAnswerController =
      TextEditingController();

  bool? passObscureText = false;
  bool? reEnterObscureText = false;
  bool isLoader = false;

  String? securityQuestionId;

  /// User register
  Future<void> registerUser({context}) async {
    try {
      isLoader = true;
      notifyListeners();
      UserCredential? userCredential = await AuthServices.registerEmailPassword(
          signUpEmailController.text, signUpPasswordController.text);

      final userModel = UserSignUpModel(
        email: signUpEmailController.text.trim(),
        id: userCredential?.user?.uid,
        imagePath: null,
        fullName: signUpFullNameController.text.trim(),
        securityQuestionId: securityQuestionId?.trim(),
        securityQuestionAnswer:
            signUpSecurityQuestionAnswerController.text.trim(),
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      );
      if (userCredential?.user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential?.user?.uid)
            .set(userModel.toJson());
        Provider.of<AppProvider>(context, listen: false)
            .getUserProfile(userCredential: userCredential);

        Get.offAllNamed(AppRouteString.addInterestScreen);
        Provider.of<AppProvider>(context, listen: false).saveUserLogin();

        Provider.of<SignUpProvider>(context, listen: false)
            .signUpScreenTextEditingControllerClear();
        isLoader = false;
      } else {
        isLoader = false;
      }
      notifyListeners();
    } catch (e) {
      print('registerUser: $e');
    }
  }

  final auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;

  /// signUpScreenTextEditingController all clear
  void signUpScreenTextEditingControllerClear() {
    signUpFullNameController.clear();
    signUpEmailController.clear();
    signUpPasswordController.clear();
    signUpReEnterPasswordController.clear();
    signUpSecurityQuestionAnswerController.clear();
    passObscureText = false;
    reEnterObscureText = false;
  }
}
