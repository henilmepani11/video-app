import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/screen/account_screen/profile_screen/edit_screen/controller/edit_provider.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_button.dart';
import 'package:video_app/widget/custom_textField.dart';
import 'package:video_app/widget/scroll_configuration.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    AppProvider appProvider = Provider.of(context, listen: false);
    EditProvider editProvider = Provider.of(context, listen: false);
    if (appProvider.userSignUpModel?.fullName != null &&
        appProvider.userSignUpModel?.email != null) {
      editProvider.userFullNameEmailShow(context: context);
    }

    editProvider.file = null;

    appProvider.getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(context);
    EditProvider editProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          leadingFunction: () {
            editProvider.file = null;
            editProvider.notifyListeners();
          },
          leadingValue: true,
          centerTitle: true,
          title: Text(AppString.editProfile,
              style: CustomTextStyle.txt20boldTitleColor),
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColor.backgroundColor21),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 28),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                        radius: 56,
                                        backgroundColor: AppColor.white),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.primaryColor,
                                      ),
                                      height: 107,
                                      width: 107,
                                      child: (
                                              // editScreenController.
                                              editProvider.file != null)
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.file(
                                                  height: 107,
                                                  width: 107,
                                                  fit: BoxFit.fill,
                                                  editProvider.file!),
                                            )
                                          : appProvider.userSignUpModel!
                                                      .imagePath !=
                                                  null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          112),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    imageUrl: appProvider
                                                            .userSignUpModel
                                                            ?.imagePath! ??
                                                        "",
                                                    placeholder: (context, url) =>
                                                        Shimmer.fromColors(
                                                            highlightColor:
                                                                AppColor
                                                                    .white
                                                                    .withOpacity(
                                                                        .7),
                                                            baseColor:
                                                                AppColor.grey,
                                                            child: Container(
                                                              height: 107,
                                                              width: 107,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle),
                                                            )),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                )
                                              : Center(
                                                  child: Text(
                                                      appProvider
                                                          .userSignUpModel!
                                                          .fullName
                                                          .toString()
                                                          .trim()
                                                          .split(" ")
                                                          .map((e) => e[0])
                                                          .take(2)
                                                          .join()
                                                          .toUpperCase(),
                                                      style: CustomTextStyle
                                                          .txt10boldWhite
                                                          .copyWith(
                                                              fontSize: 25)),
                                                ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 17.w, top: 5.h),
                                          child: GestureDetector(
                                              onTap: () {
                                                editProvider.pickedImage();
                                              },
                                              child: SvgPicture.asset(
                                                  AppAssets.camera,
                                                  height: 4.4.h)),
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              CustomTextFormField(
                                controller: editProvider.fullnameController,
                                validatorText: AppString.pleaseEnterFullName,
                                obscureText: true,
                                label: AppString.fullname,
                              ),
                              const SizedBox(height: 15),
                              CustomTextFormField(
                                focus: true,
                                controller: editProvider.emailController,
                                readOnly: true,
                                emailValidation: true,
                                validatorText:
                                    AppString.pleaseEnterEmailAddress,
                                obscureText: true,
                                label: AppString.emailAddress,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      loader: editProvider.isLoader,
                      width: 40.w,
                      height: 46,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (appProvider.userSignUpModel?.imagePath != null) {
                            await FirebaseStorage.instance
                                .refFromURL(
                                    appProvider.userSignUpModel?.imagePath ??
                                        "")
                                .delete();
                          }
                          // ignore: use_build_context_synchronously
                          await editProvider.uploadImage(context: context);
                        }
                      },
                      textStyle: CustomTextStyle.txt13boldWhite1
                          .copyWith(fontWeight: FontWeight.w600),
                      text: AppString.updateProfile,
                      color: AppColor.primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
