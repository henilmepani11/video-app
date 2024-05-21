import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/screen/sign_up_auth/sign_up/controller/sign_up_provider.dart';
import 'package:video_app/screen/sign_up_auth/sign_up/model/security_question_model.dart';
import 'package:video_app/widget/custom_button.dart';
import 'package:video_app/widget/custom_dropdown_field.dart';
import 'package:video_app/widget/custom_textField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false).securityQuestion();
    Provider.of<SignUpProvider>(context, listen: false)
        .signUpScreenTextEditingControllerClear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SignUpProvider signUpProvider = Provider.of(context);
    AppProvider appProvider = Provider.of(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    color: AppColor.backgroundColor21,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                splashColor: AppColor.transparent,
                                highlightColor: AppColor.transparent,
                                icon: Icon(Icons.arrow_back,
                                    color: AppColor.titleColor),
                                onPressed: () {
                                  Get.back();
                                  signUpProvider
                                      .signUpScreenTextEditingControllerClear();
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 29.w),
                                child:
                                    Image.asset(AppAssets.appLogo, height: 8.h),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
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
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                    child: Text(AppString.createNewAccount,
                        style: CustomTextStyle.txt16W600White)),
                Padding(
                  padding: const EdgeInsets.only(top: 21, left: 16, right: 16),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.backgroundColor21,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          CustomTextFormField(
                              controller:
                                  signUpProvider.signUpFullNameController,
                              maxLines: 1,
                              validatorText: AppString.pleaseEnterFullName,
                              obscureText: true,
                              label: AppString.fullname),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            maxLines: 1,
                            controller: signUpProvider.signUpEmailController,
                            emailValidation: true,
                            validatorText: AppString.pleaseEnterEmailAddress,
                            obscureText: true,
                            label: AppString.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            eyeSuffixIcon: GestureDetector(
                                onTap: () {
                                  if (signUpProvider.passObscureText == true) {
                                    signUpProvider.passObscureText = false;
                                  } else {
                                    signUpProvider.passObscureText = true;
                                  }
                                  signUpProvider.notifyListeners();
                                },
                                child: signUpProvider.passObscureText == true
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
                            controller: signUpProvider.signUpPasswordController,
                            passwordLength: true,
                            validatorText: AppString.pleaseEnterPassword,
                            obscureText: signUpProvider.passObscureText!,
                            label: AppString.password,
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            passwordNotMatch: true,
                            passwordNotMatchFunction: (value) {
                              if (value !=
                                  signUpProvider
                                      .signUpPasswordController.text) {
                                return AppString
                                    .passwordAndreEnterPasswordNoMatch;
                              }
                            },
                            eyeSuffixIcon: GestureDetector(
                                onTap: () {
                                  if (signUpProvider.reEnterObscureText ==
                                      true) {
                                    signUpProvider.reEnterObscureText = false;
                                  } else {
                                    signUpProvider.reEnterObscureText = true;
                                  }
                                  signUpProvider.notifyListeners();
                                },
                                child: signUpProvider.reEnterObscureText == true
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: SvgPicture.asset(AppAssets.hide,
                                            color: AppColor.textFieldHintColor))
                                    : Icon(
                                        size: 25,
                                        Icons.remove_red_eye,
                                        color: AppColor.textFieldHintColor,
                                      )),
                            maxLines: 1,
                            passwordLength: true,
                            validatorText: AppString.pleaseEnterPassword,
                            obscureText: signUpProvider.reEnterObscureText!,
                            label: AppString.rePassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.backgroundColor21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppString.securityQuestion,
                            style: CustomTextStyle.txt14W600HintColor),
                        const SizedBox(height: 8),
                        CustomDropDownField(
                            onChanged: (value) {
                              signUpProvider.securityQuestionId = value;

                              signUpProvider
                                  .signUpSecurityQuestionAnswerController
                                  .clear();
                            },
                            items: <SecurityQuestionModel>[
                              ...appProvider.securityQuestionList
                                  .map((e) => e)
                                  .toList()
                            ].map((SecurityQuestionModel value) {
                              return DropdownMenuItem(
                                  value: value.questionId,
                                  child: Text(value.questionText.toString(),
                                      style:
                                          CustomTextStyle.txt14W600HintColor));
                            }).toList(),
                            validatorText:
                                AppString.pleaseEnterSecurityQuestion),
                        SizedBox(height: 1.h),
                        CustomTextFormField(
                          controller: signUpProvider
                              .signUpSecurityQuestionAnswerController,
                          maxLines: 1,
                          validatorText: AppString.pleaseEnterAnswer,
                          obscureText: true,
                          contentPadding: true,
                          label: AppString.answer,
                          answerTrue: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.8.h, left: 16, right: 5),
                  child: Center(
                      child: CustomButton(
                          loader: signUpProvider.isLoader,
                          textStyle: CustomTextStyle.txt13boldWhite1,
                          height: 52,
                          width: double.infinity,
                          text: AppString.signUp,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              if (signUpProvider.isLoader == false) {
                                signUpProvider.registerUser(context: context);
                              }
                            }
                          },
                          color: AppColor.primaryColor)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.alreadyHaveAnAccount,
                      style: CustomTextStyle.txt14W600HintColor
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          AppString.signIn1,
                          style: CustomTextStyle.txt14W600primary1.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
