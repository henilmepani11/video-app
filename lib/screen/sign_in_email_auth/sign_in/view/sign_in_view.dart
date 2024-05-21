import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/sign_in_email_auth/sign_in/controller/sign_in_provider.dart';
import 'package:video_app/widget/custom_button.dart';
import 'package:video_app/widget/custom_textField.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SignInProvider signInProvider = Provider.of(context, listen: false);
    signInProvider.getRememberUserEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SignInProvider signInProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 30, top: 30),
                width: 100.w,
                color: AppColor.backgroundColor21,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.appLogo, height: 8.h),
                    SizedBox(height: 1.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.alfred,
                            style: CustomTextStyle.txt15boldWhite1),
                        SizedBox(width: 1.h),
                        Text(AppString.little,
                            style: CustomTextStyle.txt15W600White),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(AppString.signInToAccount,
                  style: CustomTextStyle.txt16W600White),
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 28, 0, 33),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.backgroundColor21,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          maxLines: 1,
                          controller: signInProvider.signInEmailController,
                          emailValidation: true,
                          validatorText: AppString.pleaseEnterEmailAddress,
                          obscureText: true,
                          answerTrue: false,
                          label: AppString.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          maxLines: 1,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: GestureDetector(
                                onTap: () {
                                  if (signInProvider.obscureText == true) {
                                    signInProvider.obscureText = false;
                                  } else {
                                    signInProvider.obscureText = true;
                                  }
                                  signInProvider.notifyListeners();
                                },
                                child: Text(
                                  signInProvider.obscureText == true
                                      ? AppString.hide
                                      : AppString.show,
                                  style: CustomTextStyle.txt14W600primary1
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                )),
                          ),
                          controller: signInProvider.signInPasswordController,
                          passwordLength: true,
                          validatorText: AppString.pleaseEnterPassword,
                          obscureText: signInProvider.obscureText!,
                          label: AppString.password,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 16,
                                    width: 20,
                                    child: Checkbox(
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      activeColor: AppColor.white,
                                      checkColor: AppColor.primaryColor,
                                      side: BorderSide(color: AppColor.white),
                                      value: signInProvider.isCheckedRememberMe,
                                      onChanged: (value) {
                                        if (value == true) {
                                          signInProvider
                                              .rememberUserEmailPassword(
                                                  signInProvider
                                                      .isCheckedRememberMe);
                                        } else {
                                          signInProvider.pre1?.clear();
                                        }

                                        signInProvider.isCheckedRememberMe =
                                            value!;

                                        signInProvider.notifyListeners();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(AppString.rememberMe,
                                      style: CustomTextStyle.txt14W600HintColor1
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 1.5.w),
                              child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(
                                        AppRouteString.forgotPasswordScreen);
                                  },
                                  child: Text(AppString.forgotPassword,
                                      style: CustomTextStyle.txt14W600primary1
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14))),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CustomButton(
                  loader: signInProvider.isLoader,
                  boxShadow: true,
                  textStyle: CustomTextStyle.txt13boldWhite1,
                  height: 52,
                  width: double.infinity,
                  text: AppString.signIn,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (signInProvider.isLoader == false) {
                        signInProvider.signInEmailPassword(context: context);
                        if (signInProvider.isCheckedRememberMe == true) {
                          signInProvider.rememberUserEmailPassword(
                              signInProvider.isCheckedRememberMe);
                        }
                      }
                    }
                  },
                  color: AppColor.primaryColor,
                ),
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppString.doNtHaveAnAccount,
                      style: CustomTextStyle.txt14W600HintColor1
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w400)),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(
                          AppRouteString.signUpScreen,
                        );
                      },
                      child: Text(
                        AppString.signUp,
                        style: CustomTextStyle.txt14W600primary1.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
