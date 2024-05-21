import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/route/route.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/Interested_categories/controller/interested_provider.dart';
import 'package:video_app/screen/account_screen/profile_screen/edit_screen/controller/edit_provider.dart';
import 'package:video_app/screen/category_screen/controller/category_provider.dart';
import 'package:video_app/screen/category_videos_screen/controller/category_video_provider.dart';
import 'package:video_app/screen/favourite_screen/controller/favorite_provider.dart';
import 'package:video_app/screen/forgot_password/controller/forgot_provider.dart';
import 'package:video_app/screen/home_screen/controller/home_provider.dart';
import 'package:video_app/screen/recommended_video_screen/controller/Recommended_provider.dart';
import 'package:video_app/screen/reset_password_screen_auth/reset_password/reset_provider.dart';
import 'package:video_app/screen/search_screen/controller/search_provider.dart';
import 'package:video_app/screen/sign_in_email_auth/sign_in/controller/sign_in_provider.dart';
import 'package:video_app/screen/sign_up_auth/sign_up/controller/sign_up_provider.dart';
import 'package:video_app/screen/video_screen/controller/video_provider.dart';

import 'app_controller/app_provider.dart';
import 'config/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AppProvider()),
            ChangeNotifierProvider(create: (context) => SignUpProvider()),
            ChangeNotifierProvider(create: (context) => SignInProvider()),
            ChangeNotifierProvider(
                create: (context) => ForgotPasswordProvider()),
            ChangeNotifierProvider(create: (context) => EditProvider()),
            ChangeNotifierProvider(create: (context) => InterestedProvider()),
            ChangeNotifierProvider(create: (context) => RecommendedProvider()),
            ChangeNotifierProvider(create: (context) => ResetProvider()),
            ChangeNotifierProvider(create: (context) => HomeProvider()),
            ChangeNotifierProvider(create: (context) => CategoryProvider()),
            ChangeNotifierProvider(
                create: (context) => CategoryVideoProvider()),
            ChangeNotifierProvider(create: (context) => VideoProvider()),
            ChangeNotifierProvider(create: (context) => FavoriteProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: GetMaterialApp(
            initialRoute: AppRouteString.splashScreen,
            routes: routes,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColor.backgroundColor20,
              appBarTheme: AppBarTheme(
                centerTitle: true,
                elevation: 2,
                backgroundColor: AppColor.backgroundColor21,
              ),
            ),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
