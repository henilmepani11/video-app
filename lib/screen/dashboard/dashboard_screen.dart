import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    AppProvider appProvider = Provider.of(context, listen: false);
    appProvider.getConnectivity();
    appProvider.getLocalData();
    appProvider.addInterest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, value, child) => Scaffold(
        body: Center(child: value.screen[value.selectindex]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: AppColor.titleColor.withOpacity(0.3))),
          ),
          child: Theme(
            data: ThemeData(
                highlightColor: AppColor.transparent,
                splashColor: AppColor.transparent),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColor.backgroundColor21,
              useLegacyColorScheme: false,
              showSelectedLabels: true,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              items: [
                BottomNavigationBarItem(
                  icon: value.selectindex == 0
                      ? SvgPicture.asset(AppAssets.home1,
                          color: value.selectindex == 0
                              ? AppColor.primaryColor
                              : AppColor.bottomNavigationIconColor)
                      : SvgPicture.asset(AppAssets.home,
                          color: value.selectindex == 0
                              ? AppColor.primaryColor
                              : AppColor.bottomNavigationIconColor),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: value.selectindex == 1
                      ? SvgPicture.asset(AppAssets.search1)
                      : SvgPicture.asset(AppAssets.search,
                          color: value.selectindex == 1
                              ? AppColor.primaryColor
                              : AppColor.bottomNavigationIconColor),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: value.selectindex == 2
                      ? SvgPicture.asset(AppAssets.category1,
                          color: value.selectindex == 2
                              ? AppColor.primaryColor
                              : AppColor.bottomNavigationIconColor)
                      : SvgPicture.asset(AppAssets.category,
                          color: value.selectindex == 2
                              ? AppColor.primaryColor
                              : AppColor.bottomNavigationIconColor),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: value.selectindex == 3
                      ? SvgPicture.asset(AppAssets.heart2,
                          color: value.selectindex == 3
                              ? AppColor.primaryColor
                              : AppColor.bottomNavigationIconColor)
                      : SvgPicture.asset(AppAssets.like,
                          color: value.selectindex == 3
                              ? AppColor.primaryColor
                              : AppColor.bottomNavigationIconColor),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: value.selectindex == 4
                      ? SvgPicture.asset(AppAssets.profile1,
                          color: value.selectindex == 4
                              ? AppColor.primaryColor
                              : AppColor.bottomNavigationIconColor)
                      : SvgPicture.asset(AppAssets.profile,
                          color: value.selectindex == 4
                              ? AppColor.primaryColor
                              : AppColor.bottomNavigationIconColor),
                  label: '',
                ),
              ],
              currentIndex: value.selectindex,
              selectedItemColor: AppColor.primaryColor,
              onTap: value.onTap,
            ),
          ),
        ),
      ),
    );
  }
}
