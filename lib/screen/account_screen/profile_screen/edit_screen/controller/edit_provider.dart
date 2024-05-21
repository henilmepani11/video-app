import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/widget/custom_toast.dart';

class EditProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();

  ///pic image in gallery
  File? file;
  pickedImage() async {
    try {
      bool isPhotosPermission = false;
      if (Platform.isAndroid) {
        isPhotosPermission = true;
      } else {
        isPhotosPermission = await Permission.photos.request().isGranted;
      }
      if (isPhotosPermission) {
        XFile? imagePicked =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (imagePicked != null) {
          file = File(imagePicked.path);
        }
      } else if (await Permission.photos.request().isPermanentlyDenied) {
        openAppSettings();
      }
      notifyListeners();
    } catch (e) {
      print("pickedImage $e");
    }
  }

  /// upload image in firebase storage
  bool isLoader = false;
  Future uploadImage({context}) async {
    try {
      AppProvider appProvider = Provider.of(context, listen: false);
      isLoader = true;

      notifyListeners();
      if (file?.path != null) {
        var splitPath = file?.path.split("/").last;
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child("users")
            .child(appProvider.userSignUpModel!.id!)
            .child(splitPath ?? "")
            .putFile(file!);
        TaskSnapshot taskSnapshot = await uploadTask;
        if (taskSnapshot.state == TaskState.success) {
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          appProvider.userSignUpModel!.imagePath = downloadUrl;
        }
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(appProvider.userSignUpModel?.id)
          .update({
        'fullName': fullnameController.text.trim(),
        'imagePath': appProvider.userSignUpModel!.imagePath,
        'updated_at': DateTime.now().toString(),
      });

      appProvider.userSignUpModel?.fullName = fullnameController.text.trim();

      appProvider.getUserProfile();

      appProvider.setUserName();
      Get.back();
      isLoader = false;
      customToast(message: "profile updated successfully");

      notifyListeners();
    } catch (e) {
      customToast(message: e.toString());
      isLoader = false;

      notifyListeners();
    }
  }

  /// userFullNameEmailShow
  void userFullNameEmailShow({context}) {
    AppProvider appProvider = Provider.of(context, listen: false);
    if (appProvider.userSignUpModel!.fullName != null &&
        appProvider.userSignUpModel!.email != null) {
      fullnameController.text = appProvider.userSignUpModel!.fullName!;
      emailController.text = appProvider.userSignUpModel!.email!;
    }
  }
}
