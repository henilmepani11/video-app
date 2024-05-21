import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/screen/recommended_video_screen/model/recommended_model.dart';
import 'package:video_app/widget/custom_toast.dart';

class RecommendedProvider extends ChangeNotifier {
  final TextEditingController recommendedTextEditingController =
      TextEditingController();

  /// app recommended video functionality
  recommendedVideo({context}) {
    try {
      AppProvider appProvider = Provider.of(context, listen: false);
      DocumentReference doc =
          FirebaseFirestore.instance.collection('recommended_video').doc();

      final recommendedModel = RecommendedModel(
          id: doc.id,
          createdAt: DateTime.now().toString(),
          videoLink: recommendedTextEditingController.text,
          userid: appProvider.userSignUpModel?.id);
      doc.set(recommendedModel.toJson());
      customToast(message: AppString.successfullySendLink);
      Get.back();
    } catch (e) {
      print("recommendedVideo : $e");
    }
  }
}
