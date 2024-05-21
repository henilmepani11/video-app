import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AppProvider appProvider = Provider.of(context, listen: false);
    Timer(const Duration(seconds: 3), () {
      appProvider.getUserLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.appLogo, height: 8.h),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.alfred,
                style: CustomTextStyle.txt15boldWhite1,
              ),
              SizedBox(width: 1.w),
              Text(
                AppString.little,
                style: CustomTextStyle.txt15W600White,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Lottie.asset(AppAssets.dots)
        ],
      ),
    );
  }
}
