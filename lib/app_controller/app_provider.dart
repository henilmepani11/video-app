import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/account_screen/account_screen/view/account.dart';
import 'package:video_app/screen/add_interest_screen/model/add_Interest_model.dart';
import 'package:video_app/screen/category_screen/view/category_view.dart';
import 'package:video_app/screen/favourite_screen/view/favourite_view.dart';
import 'package:video_app/screen/home_screen/view/home_screen_view.dart';
import 'package:video_app/screen/search_screen/view/search_view.dart';
import 'package:video_app/screen/sign_up_auth/sign_up/model/security_question_model.dart';
import 'package:video_app/screen/sign_up_auth/sign_up/model/sign_up_model.dart';
import 'package:video_app/shared_preferences/shared_preferences.dart';

import '../screen/add_interest_screen/model/chip_model.dart';
import '../widget/custom_toast.dart';

class AppProvider extends ChangeNotifier {
  List screen = [
    const HomeScreen(),
    const SearchScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const AccountScreen(),
  ];
  int selectindex = 0;
  void onTap(int index) {
    selectindex = index;
    notifyListeners();
  }

  /// storeCategory
  List storeLikedCategoryList = [];
  storeCategory() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      storeLikedCategoryList = value.data()?["userFavoriteCategory"] ?? [];
    });
  }

  ///interested category update
  interestedCategoryUpdateTap({interestedProvider}) async {
    isLoader = true;

    notifyListeners();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userSignUpModel?.id)
        .update({
      'interest': interestedProvider.localInterestList.map((e) => e),
      "updated_at": DateTime.now().toString()
    });
    await getUserProfile();
    getLocalData();
    isLoader = false;
    notifyListeners();
    Get.back();
  }

  ///addInterest Tap Function
  addInterestTapFunction() async {
    if (addTrueInterestChipList.isNotEmpty) {
      if (isLoader == false) {
        isLoader = true;

        notifyListeners();
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userSignUpModel?.id)
            .update({
          'interest': addTrueInterestChipList.map((e) => e.interestId).toList()
        });

        getUserProfile();
        getLocalData();
        isLoader = false;
        notifyListeners();
        Get.offAllNamed(AppRouteString.dashboardScreen);
      }
    }
  }

  /// check internet connection
  ConnectivityResult? previousResult;
  getConnectivity() {
    Connectivity().onConnectivityChanged.listen((_) async {
      ConnectivityResult result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        customToast(message: AppString.noInternetConnection);
      } else if (previousResult == ConnectivityResult.none) {
        if (result == ConnectivityResult.mobile) {
          customToast(message: AppString.connectInternet);
        } else if (result == ConnectivityResult.wifi) {
          customToast(message: AppString.connectInternet);
        }
      }
      previousResult = result;
    });
  }

  /// add_interest_screen true chip List
  List<ChipModel> addTrueInterestChipList = [];
  void addInterestChipAdd({String? name, String? interestId}) {
    addTrueInterestChipList.add(ChipModel(
        name: name, id: DateTime.now().toString(), interestId: interestId));
    notifyListeners();
  }

  /// FirebaseFirestore user data get
  UserSignUpModel? userSignUpModel;
  getUserProfile({UserCredential? userCredential}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(userCredential?.user?.uid ?? userSignUpModel?.id)
          .get();

      if (data.exists) {
        userSignUpModel = UserSignUpModel(
          email: data["email"],
          id: data["id"],
          fullName: data["fullName"],
          imagePath: data["imagePath"],
          securityQuestionId: data["security_question_id"],
          securityQuestionAnswer: data["security_question_ans"],
          interestList: data["interest"],
          userFavoriteCategory: data["userFavoriteCategory"],
          likedVideo: data["likedVideo"],
        );
      }
      setUserName();
      notifyListeners();
    } catch (e) {
      print('getUserProfile: $e');
    }
  }

  final auth = FirebaseAuth.instance;
  bool isLoader = false;

  ///saveUserdata in Local
  void setUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
          AppKey.userSignUpModelKey, jsonEncode(userSignUpModel?.toJson()));
      notifyListeners();
    } catch (e) {
      print("setUserName :$e");
    }
  }

  ///getUserdata in Local
  SharedPreferences? pre;
  void getLocalData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      pre = prefs;
      Map<String, dynamic> userSignUpTempModel =
          jsonDecode(prefs.getString(AppKey.userSignUpModelKey) ?? '');
      UserSignUpModel userSignUpTempModel1 =
          UserSignUpModel.fromJson(userSignUpTempModel);
      userSignUpModel = userSignUpTempModel1;
      notifyListeners();
    } catch (e) {
      print("getLocalData: $e");
    }
  }

  /// userSignOut
  void userSignOut() async {
    await auth.signOut();
    pre?.clear();
    selectindex = 0;
    addTrueInterestChipList.clear();
    Get.offAllNamed(AppRouteString.signInScreen);
  }

  /// save login in local
  void saveUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userId", userSignUpModel?.id ?? "");
  }

  /// get login in local
  void getUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("userId");
    if (token != null) {
      Get.offAllNamed(AppRouteString.dashboardScreen);
    } else {
      Get.offAllNamed(AppRouteString.signInScreen);
    }
  }

  /// Firestore securityQuestion data get
  List<SecurityQuestionModel> securityQuestionList = [];
  void securityQuestion() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('security_question')
          .where("live", isEqualTo: true)
          .get();

      securityQuestionList = querySnapshot.docs
          .map((e) => SecurityQuestionModel(
              live: e.get("live"),
              index: e.get("index"),
              questionId: e.get("question_id"),
              questionText: e.get("question_text")))
          .toList();
    } catch (e) {
      print('securityQuestion: $e');
    }
    notifyListeners();
  }

  /// Firestore InterestList data get
  List<AddInterestModel> addInterestList = [];
  void addInterest() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('interest')
          .where("live", isEqualTo: true)
          .get();

      addInterestList = querySnapshot.docs
          .map(
            (e) => AddInterestModel(
              live: e.get("live"),
              index: e.get("index"),
              interestId: e.get("interest_id"),
              interestText: e.get("interest_text"),
            ),
          )
          .toList();
    } catch (e) {
      print('addInterest: $e');
    }
  }
}
