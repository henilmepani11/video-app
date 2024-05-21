import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/screen/recommended_video_screen/controller/Recommended_provider.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_button.dart';
import 'package:video_app/widget/custom_textField.dart';

class RecommendedVideoScreen extends StatefulWidget {
  const RecommendedVideoScreen({Key? key}) : super(key: key);

  @override
  State<RecommendedVideoScreen> createState() => _RecommendedVideoScreenState();
}

class _RecommendedVideoScreenState extends State<RecommendedVideoScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    RecommendedProvider recommendedProvider =
        Provider.of(context, listen: false);
    recommendedProvider.recommendedTextEditingController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RecommendedProvider recommendedProvider =
        Provider.of(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
            leadingFunction: () {},
            leadingValue: true,
            centerTitle: true,
            title: Text(AppString.recommendedVideo,
                style: CustomTextStyle.txt20boldTitleColor)),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.w, top: 27),
                  child: Text(AppString.recommendedVideoText,
                      style: CustomTextStyle.txt14W400HintColor),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: CustomTextFormField(
                    passwordNotMatch: true,
                    passwordNotMatchFunction: (value) {
                      String pattern =
                          "((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?";
                      RegExp regExp = RegExp(pattern);
                      String? val = regExp.stringMatch(value);
                      if (val == null) {
                        return AppString.pleaseEnterYoutubeURL;
                      }
                    },
                    controller:
                        recommendedProvider.recommendedTextEditingController,
                    maxLines: 2,
                    validatorText: AppString.pleaseEnterLink,
                    obscureText: true,
                    contentPadding: true,
                    label: AppString.linkHere,
                    answerTrue: true,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: CustomButton(
                      height: 46,
                      width: 38.w,
                      textStyle: CustomTextStyle.txt15W500White,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          recommendedProvider.recommendedVideo(
                              context: context);
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
