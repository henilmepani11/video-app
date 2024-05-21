import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/widget/custom_button.dart';
import 'package:video_app/widget/custom_textField.dart';

showAlertDialog(
    {context,
    TextEditingController? controller,
    formkey,
    onTapFunction,
    loader}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      controller?.clear();
      return Form(
        key: formkey,
        child: StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: AppColor.backgroundColor21,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.w),
                  child: IconButton(
                      highlightColor: AppColor.transparent,
                      splashColor: AppColor.transparent,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColor.white,
                        weight: 20.2,
                      )),
                ),
                CustomTextFormField(
                  controller: controller,
                  validatorText: AppString.pleaseEnterReason,
                  obscureText: true,
                  answerTrue: false,
                  label: AppString.reportReason,
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CustomButton(
                  loader: loader,
                  boxShadow: true,
                  textStyle: CustomTextStyle.txt13boldWhite1,
                  height: 52,
                  width: double.infinity,
                  text: AppString.submit,
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      onTapFunction();
                      Get.back();
                    }
                  },
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
