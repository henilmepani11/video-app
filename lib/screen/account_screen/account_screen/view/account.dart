import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/account_screen/account_screen/widget/custom_divider.dart';
import 'package:video_app/screen/account_screen/account_screen/widget/custom_setting_option_body.dart';
import 'package:video_app/screen/sign_in_email_auth/sign_in/controller/sign_in_provider.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_button.dart';
import 'package:video_app/widget/custom_see_all_container.dart';
import 'package:video_app/widget/scroll_configuration.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false).getLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(context, listen: false);
    SignInProvider signInProvider = Provider.of(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
          leadingFunction: () {},
          centerTitle: true,
          title: Text(AppString.account,
              style: CustomTextStyle.txt20boldTitleColor)),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 9, right: 9, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<AppProvider>(
                    builder: (context, value, child) => Container(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
                      decoration: BoxDecoration(
                          color: AppColor.backgroundColor21,
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.h, left: 17),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 49,
                                    backgroundColor: AppColor.white),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.primaryColor),
                                  height: 93,
                                  width: 93,
                                  child:
                                      // accountScreenController
                                      appProvider.userSignUpModel?.imagePath ==
                                              null
                                          ? Center(
                                              child: Text(
                                                  (appProvider.userSignUpModel
                                                              ?.fullName
                                                              .toString() ??
                                                          "")
                                                      .trim()
                                                      .split(" ")
                                                      .map((e) => e[0])
                                                      .take(2)
                                                      .join()
                                                      .toUpperCase(),
                                                  style: CustomTextStyle
                                                      .txt10boldWhite
                                                      .copyWith(fontSize: 25)),
                                            )
                                          : (appProvider.userSignUpModel
                                                      ?.imagePath !=
                                                  null)
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
                                                              height: 93,
                                                              width: 93,
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
                                              : null,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appProvider.userSignUpModel?.fullName
                                              .toString() ??
                                          "",
                                      style:
                                          CustomTextStyle.txt20boldTitleColor,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                        padding: EdgeInsets.only(right: 3.w),
                                        child: CustomSeeAllContainer(
                                          width: 113,
                                          style: CustomTextStyle
                                              .txt15w500Primary
                                              .copyWith(fontSize: 15),
                                          height: 36,
                                          text: AppString.seeProfile,
                                          onTap: () {
                                            Get.toNamed(
                                                AppRouteString.profileScreen);
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.backgroundColor21,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: CustomSettingOptionBody(
                                onTap: () {
                                  Get.toNamed(AppRouteString
                                      .interestedCategoriesScreen);
                                },
                                text: AppString.myInterest,
                                image: AppAssets.thumb),
                          ),
                          const CustomDivider(),
                          Padding(
                            padding: EdgeInsets.only(top: 2.5.h),
                            child: CustomSettingOptionBody(
                                onTap: () {
                                  appProvider.selectindex = 3;
                                  appProvider.notifyListeners();
                                },
                                text: AppString.favouriteVideosList,
                                image: AppAssets.like),
                          ),
                          const CustomDivider(),
                          Padding(
                            padding: EdgeInsets.only(top: 2.5.h),
                            child: CustomSettingOptionBody(
                                onTap: () {
                                  appProvider.selectindex = 2;
                                  appProvider.notifyListeners();
                                },
                                text: AppString.allCategories,
                                image: AppAssets.category),
                          ),
                          const CustomDivider(),
                          Padding(
                            padding: EdgeInsets.only(top: 2.5.h),
                            child: CustomSettingOptionBody(
                                onTap: () {
                                  Get.toNamed(
                                      AppRouteString.recommendedVideoScreen);
                                },
                                text: AppString.recommendedVideo,
                                image: AppAssets.thumb),
                          ),
                          const CustomDivider(),
                          Padding(
                            padding: EdgeInsets.only(top: 2.5.h),
                            child: CustomSettingOptionBody(
                                onTap: () {
                                  Get.toNamed(AppRouteString.aboutUsScreen);
                                },
                                text: AppString.aboutUs,
                                image: AppAssets.aboutUs),
                          ),
                          const CustomDivider(),
                          Padding(
                            padding: EdgeInsets.only(top: 2.5.h),
                            child: CustomSettingOptionBody(
                                onTap: () {
                                  Get.toNamed(AppRouteString.settingScreen);
                                },
                                text: AppString.settings,
                                image: AppAssets.setting),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 7, bottom: 13),
                    child: CustomButton(
                        textStyle: CustomTextStyle.txt13boldWhite,
                        width: 118,
                        height: 46,
                        isBack: appProvider.isLoader == true ? false : true,
                        onTap: () {
                          appProvider.userSignOut();
                          signInProvider.getRememberUserEmailPassword();
                        },
                        color: AppColor.primaryColor,
                        text: AppString.signOut),
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
