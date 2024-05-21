import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/screen/reset_password_screen_auth/reset_password/reset_provider.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_button.dart';
import 'package:video_app/widget/custom_textField.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ResetProvider resetProvider = Provider.of(context, listen: false);
    resetProvider.resetPasswordScreenTextEditingControllerClear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResetProvider resetProvider = Provider.of(context, listen: false);
    return Consumer<ResetProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: CustomAppBar(
              leadingFunction: () {
                resetProvider.resetPasswordScreenTextEditingControllerClear();
              },
              leadingValue: true,
              centerTitle: true,
              title: Text(AppString.resetPassword,
                  style: CustomTextStyle.txt20boldTitleColor)),
          body: Padding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                        color: AppColor.backgroundColor21,
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            maxLines: 1,
                            eyeSuffixIcon: GestureDetector(
                                onTap: () {
                                  if (resetProvider.currentObscureText ==
                                      true) {
                                    resetProvider.currentObscureText = false;
                                  } else {
                                    resetProvider.currentObscureText = true;
                                  }

                                  resetProvider.notifyListeners();
                                },
                                child:
                                    // resetPasswordScreenController
                                    resetProvider.currentObscureText == true
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: SvgPicture.asset(
                                              AppAssets.hide,
                                              color:
                                                  AppColor.textFieldHintColor,
                                            ),
                                          )
                                        : Icon(
                                            size: 25,
                                            Icons.remove_red_eye,
                                            color: AppColor.textFieldHintColor,
                                          )),
                            controller: resetProvider.currentPasswordController,
                            passwordLength: true,
                            validatorText: AppString.pleaseEnterCurrentPassword,
                            obscureText: resetProvider.currentObscureText!,
                            label: AppString.currentPassword,
                          ),
                          SizedBox(height: 1.h),
                          CustomTextFormField(
                            obscureText: resetProvider.newPasswordObscureText!,
                            controller:
                                resetProvider.newReSetPasswordController,
                            passwordLength: true,
                            validatorText: AppString.pleaseEnterNewPassword,
                            maxLines: 1,
                            eyeSuffixIcon: GestureDetector(
                                onTap: () {
                                  if (resetProvider.newPasswordObscureText ==
                                      true) {
                                    resetProvider.newPasswordObscureText =
                                        false;
                                  } else {
                                    resetProvider.newPasswordObscureText = true;
                                  }

                                  resetProvider.notifyListeners();
                                },
                                child: resetProvider.newPasswordObscureText ==
                                        true
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: SvgPicture.asset(
                                          AppAssets.hide,
                                          color: AppColor.textFieldHintColor,
                                        ),
                                      )
                                    : Icon(
                                        size: 25,
                                        Icons.remove_red_eye,
                                        color: AppColor.textFieldHintColor,
                                      )),
                            label: AppString.newPassword,
                          ),
                          SizedBox(height: 1.h),
                          CustomTextFormField(
                            eyeSuffixIcon: GestureDetector(
                                onTap: () {
                                  if (resetProvider.reNewPasswordObscureText ==
                                      true) {
                                    resetProvider.reNewPasswordObscureText =
                                        false;
                                  } else {
                                    resetProvider.reNewPasswordObscureText =
                                        true;
                                  }

                                  resetProvider.notifyListeners();
                                },
                                child: resetProvider.reNewPasswordObscureText ==
                                        true
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: SvgPicture.asset(
                                          AppAssets.hide,
                                          color: AppColor.textFieldHintColor,
                                        ),
                                      )
                                    : Icon(
                                        size: 25,
                                        Icons.remove_red_eye,
                                        color: AppColor.textFieldHintColor,
                                      )),
                            maxLines: 1,
                            passwordNotMatchFunction: (value) {
                              if (value !=
                                  resetProvider
                                      .newReSetPasswordController.text) {
                                return AppString.passwordNotMatch;
                              }
                              return null;
                            },
                            passwordNotMatch: true,
                            controller:
                                resetProvider.reSetReEnterNewPasswordController,
                            passwordLength: true,
                            validatorText: AppString.pleaseReEnterNewPassword,
                            obscureText:
                                resetProvider.reNewPasswordObscureText!,
                            label: AppString.reenterNewPassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CustomButton(
                        loader: resetProvider.isLoader,
                        height: 46,
                        textStyle: CustomTextStyle.txt15W500White,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            resetProvider.changeEmailPassword();
                          }
                        },
                        text: AppString.resetPassword,
                        color: AppColor.primaryColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
