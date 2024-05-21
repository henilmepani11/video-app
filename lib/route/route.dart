import 'package:flutter/cupertino.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/Interested_categories/view/Interested_categories_view.dart';
import 'package:video_app/screen/about_us_screen/about_us_view.dart';
import 'package:video_app/screen/account_screen/profile_screen/edit_screen/view/edit_screen_view.dart';
import 'package:video_app/screen/account_screen/profile_screen/view/profile_screen_view.dart';
import 'package:video_app/screen/add_interest_screen/view/add_interest.dart';
import 'package:video_app/screen/category_screen/view/category_view.dart';
import 'package:video_app/screen/category_videos_screen/view/category_videos_screen.dart';
import 'package:video_app/screen/dashboard/dashboard_screen.dart';
import 'package:video_app/screen/favourite_screen/view/favourite_view.dart';
import 'package:video_app/screen/forgot_password/view/forgot_password.dart';
import 'package:video_app/screen/recommended_video_screen/view/recommended_video_screen_view.dart';
import 'package:video_app/screen/reset_password_screen_auth/reset_password/view/reset_password_view.dart';
import 'package:video_app/screen/setting_screen/setting_view.dart';
import 'package:video_app/screen/sign_in_email_auth/sign_in/view/sign_in_view.dart';
import 'package:video_app/screen/sign_up_auth/sign_up/view/sign_up_view.dart';
import 'package:video_app/screen/splash_screen/splash_screen.dart';
import 'package:video_app/screen/video_screen/view/video_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRouteString.splashScreen: (context) => const SplashScreen(),
  AppRouteString.signInScreen: (context) => const SignInScreen(),
  AppRouteString.signUpScreen: (context) => const SignUpScreen(),
  AppRouteString.addInterestScreen: (context) => const AddInterestScreen(),
  AppRouteString.dashboardScreen: (context) => const DashboardScreen(),
  AppRouteString.categoryVideosScreen: (context) =>
      const CategoryVideosScreen(),
  AppRouteString.videoScreen: (context) => const VideoScreen(),
  AppRouteString.favoriteScreen: (context) => const FavoriteScreen(),
  AppRouteString.categoryScreen: (context) => const CategoryScreen(),
  AppRouteString.recommendedVideoScreen: (context) =>
      const RecommendedVideoScreen(),
  AppRouteString.aboutUsScreen: (context) => const AboutUsScreen(),
  AppRouteString.forgotPasswordScreen: (context) =>
      const ForgotPasswordScreen(),
  AppRouteString.settingScreen: (context) => const SettingScreen(),
  AppRouteString.profileScreen: (context) => const ProfileScreen(),
  AppRouteString.editScreen: (context) => const EditScreen(),
  AppRouteString.resetPasswordScreen: (context) => const ResetPasswordScreen(),
  AppRouteString.interestedCategoriesScreen: (context) =>
      const InterestedCategoriesScreen(),
};
