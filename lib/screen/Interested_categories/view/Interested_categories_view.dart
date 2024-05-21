import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/screen/Interested_categories/controller/interested_provider.dart';
import 'package:video_app/screen/add_interest_screen/model/add_Interest_model.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_button.dart';

class InterestedCategoriesScreen extends StatefulWidget {
  const InterestedCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<InterestedCategoriesScreen> createState() =>
      _InterestedCategoriesScreenState();
}

class _InterestedCategoriesScreenState
    extends State<InterestedCategoriesScreen> {
  @override
  void initState() {
    AppProvider appProvider = Provider.of(context, listen: false);
    InterestedProvider interestedProvider = Provider.of(context, listen: false);

    interestedProvider.localInterestList =
        appProvider.userSignUpModel?.interestList?.map((e) => e).toList() ?? [];

    appProvider.addInterest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(context, listen: false);
    InterestedProvider interestedProvider = Provider.of(context, listen: false);
    return Scaffold(
      floatingActionButton: Consumer<AppProvider>(
        builder: (context, value, child) => Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: CustomButton(
              loader: appProvider.isLoader,
              boxShadow: false,
              textStyle: CustomTextStyle.txt13boldWhite1,
              height: 52,
              width: 90.w,
              onTap: () async {
                appProvider.interestedCategoryUpdateTap(
                    interestedProvider: interestedProvider);
              },
              text: AppString.updateInterest,
              color: AppColor.primaryColor),
        ),
      ),
      appBar: CustomAppBar(
        leadingValue: true,
        leadingFunction: () {},
        centerTitle: true,
        title: Text(AppString.interestedCategories,
            style: CustomTextStyle.txt20boldTitleColor.copyWith(
                color: AppColor.signInAccountTitleColor,
                fontWeight: FontWeight.w700,
                fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Container(
                padding: const EdgeInsets.only(top: 14, bottom: 19),
                decoration: BoxDecoration(
                    color: AppColor.backgroundColor21,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(AppString.myInterest,
                            style: CustomTextStyle.txt16W600primary)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Consumer<InterestedProvider>(
                    builder: (context, value, child) => Expanded(
                      child: Wrap(
                        spacing: 10,
                        children: interestedProvider.localInterestList
                            .map((chipName) {
                          AddInterestModel interest =
                              appProvider.addInterestList.firstWhere(
                                  (element) => element.interestId == chipName);

                          return Chip(
                            onDeleted: () async {
                              interestedProvider.localInterestList.removeWhere(
                                  (element) => element == chipName);
                              interestedProvider.notifyListeners();
                            },
                            deleteIconColor: AppColor.chipDeleteColor,
                            deleteIcon: SvgPicture.asset(AppAssets.deleteIcon,
                                height: 10.h),
                            label: Text(interest.interestText,
                                style: CustomTextStyle.txt15W600Grey.copyWith(
                                    color: appProvider.addTrueInterestChipList
                                            .any((element) =>
                                                element.name == chipName)
                                        ? AppColor.white
                                        : AppColor.textFieldHintColor1)),
                            backgroundColor: appProvider.addTrueInterestChipList
                                    .any((element) => element.name == chipName)
                                ? AppColor.primaryColor
                                : AppColor.chipColor,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
                padding: const EdgeInsets.only(left: 16, top: 20),
                child: Text(AppString.updateInterest,
                    style: CustomTextStyle.txt16W600primary)),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 2.5.h),
              child: Row(
                children: [
                  Consumer<InterestedProvider>(
                    builder: (context, value, child) => Expanded(
                      child: Wrap(
                          spacing: 10,
                          children: appProvider.addInterestList.map((chipName) {
                            return GestureDetector(
                              onTap: () {
                                if (!value.localInterestList.any((element) =>
                                    element == chipName.interestId)) {
                                  value.localInterestListFunction(
                                      id: chipName.interestId);
                                }

                                value.notifyListeners();
                              },
                              child: Chip(
                                  label: Text(chipName.interestText,
                                      style: CustomTextStyle.txt15W600Grey
                                          .copyWith(
                                              color: value.localInterestList
                                                      .any((element) =>
                                                          element ==
                                                          chipName.interestId)
                                                  ? AppColor.white
                                                  : AppColor
                                                      .textFieldHintColor1)),
                                  backgroundColor: value.localInterestList.any(
                                          (element) =>
                                              element == chipName.interestId)
                                      ? AppColor.primaryColor
                                      : AppColor.chipColor),
                            );
                          }).toList()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
