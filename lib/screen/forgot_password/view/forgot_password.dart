import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/screen/forgot_password/controller/forgot_provider.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_button.dart';
import 'package:video_app/widget/custom_textField.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<ForgotPasswordProvider>(context, listen: false)
        .forgotEmailPasswordController
        .clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ForgotPasswordProvider forgotPasswordProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          leadingFunction: () {},
          leadingValue: true,
          centerTitle: true,
          title: Text(
            AppString.forgotPassword1,
            style: CustomTextStyle.txt20boldTitleColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.backgroundColor21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          maxLines: 1,
                          controller: forgotPasswordProvider
                              .forgotEmailPasswordController,
                          emailValidation: true,
                          validatorText: AppString.pleaseEnterEmailAddress,
                          obscureText: true,
                          answerTrue: false,
                          label: AppString.emailAddress,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                Center(
                  child: CustomButton(
                      loader: forgotPasswordProvider.loader,
                      height: 46,
                      width: 38.w,
                      textStyle: CustomTextStyle.txt15W500White,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          forgotPasswordProvider.forgotPassword();
                        }
                      },
                      color: AppColor.primaryColor,
                      text: AppString.sendLink),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
