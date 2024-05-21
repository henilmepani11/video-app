import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_button.dart';

class AddInterestScreen extends StatefulWidget {
  const AddInterestScreen({Key? key}) : super(key: key);

  @override
  State<AddInterestScreen> createState() => _AddInterestScreenState();
}

class _AddInterestScreenState extends State<AddInterestScreen> {
  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false).addInterest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        leadingFunction: () {},
        centerTitle: true,
        title: Text(AppString.addInterest,
            style: CustomTextStyle.txt20boldTitleColor.copyWith(
                color: AppColor.signInAccountTitleColor,
                fontWeight: FontWeight.w700,
                fontSize: 18)),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: CustomButton(
            loader: appProvider.isLoader,
            boxShadow: false,
            textStyle: CustomTextStyle.txt13boldWhite1,
            height: 52,
            width: 90.w,
            onTap: () async {
              appProvider.addInterestTapFunction();
            },
            text: AppString.addInterest,
            color: appProvider.addTrueInterestChipList.isNotEmpty
                ? AppColor.primaryColor
                : AppColor.sliderColor),
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
                      child: Text(
                        AppString.myInterest,
                        style: CustomTextStyle.txt16W600primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    appProvider.addTrueInterestChipList.isNotEmpty
                        ? Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                    spacing: 10,
                                    children: appProvider
                                        .addTrueInterestChipList
                                        .map((e) {
                                      return Chip(
                                        onDeleted: () {
                                          appProvider.addTrueInterestChipList
                                              .removeWhere((element) =>
                                                  element.id == e.id);
                                          appProvider.notifyListeners();
                                        },
                                        deleteIconColor:
                                            AppColor.chipDeleteColor,
                                        deleteIcon: SvgPicture.asset(
                                            AppAssets.deleteIcon,
                                            height: 10.h),
                                        label: Text(e.name.toString(),
                                            style: CustomTextStyle.txt15W600Grey
                                                .copyWith(
                                                    color: AppColor
                                                        .textFieldHintColor1)),
                                        backgroundColor: AppColor.chipColor,
                                      );
                                    }).toList()),
                              )
                            ],
                          )
                        : Center(
                            child: Text(AppString.noInterestAdded,
                                style: CustomTextStyle.txt15W600Grey.copyWith(
                                    color: AppColor.textFieldHintColor1)),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                AppString.addInterest,
                style: CustomTextStyle.txt16W600primary,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 2.5.h),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                        spacing: 10,
                        children: appProvider.addInterestList.map((chipName) {
                          return GestureDetector(
                            onTap: () {
                              if (!appProvider.addTrueInterestChipList.any(
                                  (element) =>
                                      element.name == chipName.interestText)) {
                                appProvider.addInterestChipAdd(
                                    name: chipName.interestText,
                                    interestId: chipName.interestId);
                              }
                            },
                            child: Chip(
                              label: Text(chipName.interestText,
                                  style: CustomTextStyle.txt15W600Grey.copyWith(
                                      color: appProvider.addTrueInterestChipList
                                              .any((element) =>
                                                  element.name ==
                                                  chipName.interestText)
                                          ? AppColor.white
                                          : AppColor.textFieldHintColor1)),
                              backgroundColor: appProvider
                                      .addTrueInterestChipList
                                      .any((element) =>
                                          element.name == chipName.interestText)
                                  ? AppColor.primaryColor
                                  : AppColor.chipColor,
                            ),
                          );
                        }).toList()),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
