import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/scroll_configuration.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false).getLocalData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        leadingFunction: () {},
        leadingValue: true,
        centerTitle: true,
        title:
            Text(AppString.profile, style: CustomTextStyle.txt20boldTitleColor),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w, top: 5, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRouteString.editScreen);
              },
              child: Container(
                width: 23.w,
                height: 36,
                color: AppColor.primaryColor.withOpacity(0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.edit, height: 3.5.h),
                    const SizedBox(width: 6),
                    Text(AppString.edit, style: CustomTextStyle.txt14boldWhite),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 28, bottom: 28),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColor.backgroundColor21,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                                radius: 56, backgroundColor: AppColor.white),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primaryColor,
                              ),
                              height: 107,
                              width: 107,
                              child: appProvider.userSignUpModel!.imagePath ==
                                      null
                                  ? Center(
                                      child: Text(
                                          appProvider.userSignUpModel!.fullName
                                              .toString()
                                              .trim()
                                              .split(" ")
                                              .map((e) => e[0])
                                              .take(2)
                                              .join()
                                              .toUpperCase(),
                                          style: CustomTextStyle.txt10boldWhite
                                              .copyWith(fontSize: 25)),
                                    )
                                  : (appProvider.userSignUpModel?.imagePath !=
                                          null)
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(112),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl: appProvider
                                                    .userSignUpModel
                                                    ?.imagePath! ??
                                                "",
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                                    highlightColor: AppColor
                                                        .white
                                                        .withOpacity(.7),
                                                    baseColor: AppColor.grey,
                                                    child: Container(
                                                      height: 107,
                                                      width: 107,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle),
                                                    )),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        )
                                      : null,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Text(
                          appProvider.userSignUpModel?.fullName.toString() ??
                              "",
                          style: CustomTextStyle.txt20boldTitleColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 1.h),
                      Text(
                        appProvider.userSignUpModel?.email.toString() ?? "",
                        style: CustomTextStyle.txt11HintColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
