import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/category_videos_screen/model/category_videos_model.dart';
import 'package:video_app/screen/search_screen/controller/search_provider.dart';
import 'package:video_app/screen/search_screen/view/search_shimmer.dart';
import 'package:video_app/widget/custom_video_details_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider = Provider.of(context, listen: false);
    return Consumer<SearchProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                            controller: searchProvider.searchController,
                            onChanged: (value) {
                              searchProvider.searchVideos(
                                  query: value.toLowerCase());

                              searchProvider.notifyListeners();
                            },
                            style: CustomTextStyle.txt14W400HintColor,
                            cursorColor: AppColor.grey,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 1, left: 5.w),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  searchProvider.searchController.clear();
                                  searchProvider.searchList.clear();

                                  searchProvider.notifyListeners();
                                },
                                child: Icon(Icons.close,
                                    color: AppColor.textFieldHintColor1,
                                    size: 30),
                              ),
                              hintText: AppString.searchVideoOrCategories,
                              hintStyle: CustomTextStyle.txt12W600Grey,
                              fillColor: AppColor.chipColor,
                              filled: true,
                              border: CustomBoderStyle.outlineInputBorder2,
                              focusedBorder:
                                  CustomBoderStyle.outlineInputBorder2,
                              errorBorder: CustomBoderStyle.outlineInputBorder2,
                              enabledBorder:
                                  CustomBoderStyle.outlineInputBorder2,
                            )),
                      ),
                    ),
                    const SizedBox(height: 21),
                    searchProvider.isLoader == true
                        ? const SearchShimmer()
                        : searchProvider.searchList.isNotEmpty
                            ? Container(
                                color: AppColor.backgroundColor20,
                                height: 500,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: searchProvider.searchList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRouteString.videoScreen,
                                              arguments: VideoArguments(
                                                categoryId: searchProvider
                                                    .searchList[index]
                                                    .categoryId,
                                                index: searchProvider
                                                    .searchList[index].index,
                                                videoId: searchProvider
                                                    .searchList[index].videoId,
                                                videoLink:
                                                    // searchAppController
                                                    searchProvider
                                                        .searchList[index]
                                                        .videoLink,
                                              ));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          color: AppColor.backgroundColor20,
                                          child: CustomVideoDetailsContainer(
                                              valueTrue: true,
                                              fav: searchProvider
                                                  .searchList[index]
                                                  .totalFavorite,
                                              view: searchProvider
                                                  .searchList[index].totalView,
                                              image: searchProvider
                                                  .searchList[index].thumbnail,
                                              titleText: searchProvider
                                                  .searchList[index].videoName,
                                              isMoreIcon: false),
                                        ));
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 1.5.h);
                                  },
                                ),
                              )
                            : Center(
                                heightFactor: 34,
                                child: Text("No Search Video",
                                    style: CustomTextStyle.txt14W700HintColor11
                                        .copyWith(fontSize: 15)),
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
